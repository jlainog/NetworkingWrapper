/*:
 # Networking Wrapper
 
 Example of the use of the NetworkingWrapper using Alamofire
 
 [Http Request Documentation](https://www.w3.org/Protocols/rfc2616/rfc2616-sec5.html#sec5)
 
 ## Features
 
 * A way to cleary identify the Host and the related RequestLine
 * Custom configuration of each Host
 * Specify Path, HttpMethod and Encoding for each RequestLine
 * Easy set of Enviroments

Lets say we want to reach a media service that expose info about Movies and TV Shows
 
 [The MovieDB API](https://www.themoviedb.org/documentation/api)
 
 ### General Features Movies
 * Top rated movies
 * Upcoming movies
 * Now playing movies
 * Popular movies
### General Features TV Shows
 * Popular TV shows
 * Top rated TV shows
 * On the air TV shows
 * Airing today TV shows
 */
import PlaygroundSupport
/*:
 Now we define and interface for the movies expected RequestLine
 */
protocol MoviesRequestLine {
    static var nowPlaying : RequestLineAlamofireImpl { get }
    static var popular : RequestLineAlamofireImpl { get }
    static var topRated : RequestLineAlamofireImpl { get }
    static var upcoming : RequestLineAlamofireImpl { get }
}
/*:
 Then we define the service with the Host and the related RequestLine
 */
struct TheMovieDB {
    static let host = HostImpl(listRequest: [Environment.default : "https://api.themoviedb.org/3"],
                               parameters: ["api_key": "1f4d7de5836b788bdfd897c3e0d0a24b"])
    static let imgBaseURL =  "https://image.tmdb.org/t/p/w300"
    
    struct MovieRequestLines : MoviesRequestLine {}
    struct SeriesRequestLines { }
}
/*:
 Implement the RequestLine
 */
extension TheMovieDB.MovieRequestLines {
    static let nowPlaying = RequestLineAlamofireImpl(path: "/movie/now_playing",
                                                  httpMethod: .get)
    static let popular = RequestLineAlamofireImpl(path: "/movie/popular")
    static let topRated = RequestLineAlamofireImpl(path: "/movie/top_rated")
    static let upcoming = RequestLineAlamofireImpl(path: "/movie/upcoming")
}

extension TheMovieDB.SeriesRequestLines {
    static let airingToday = RequestLineAlamofireImpl(path: "/tv/airing_today")
    static let onTheAir = RequestLineAlamofireImpl(path: "/tv/on_the_air")
    static let popular = RequestLineAlamofireImpl(path: "/tv/popular")
    static let topRated = RequestLineAlamofireImpl(path: "/tv/top_rated")
}
/*:
 Test the service baseURL given the Environment and RequestLine Paths
 */
TheMovieDB.host.baseURL()
TheMovieDB.MovieRequestLines.topRated.path
TheMovieDB.SeriesRequestLines.topRated.path
/*:
 Now connect all together.
 Declare a NetworkRequest passing the Host and the Endpoind.
 */
let networkRequest = NetworkRequestAlamofireImpl(host: TheMovieDB.host,
                                                 resquestLine: TheMovieDB.MovieRequestLines.nowPlaying)
/*:
 Test the NetworkRequest absoluteURL
 */
networkRequest.absoluteURL()
/*:
 Then fire it and Enjoy.
 */
PlaygroundPage.current.needsIndefiniteExecution = true
networkRequest.fire { (response) in
    let value = response.result.value as? Dictionary<String,Any>
    let results = value?["results"] as? Array<Any>
    
    results?.first
    print(results?.first ?? "Error")
    PlaygroundPage.current.finishExecution()
}
