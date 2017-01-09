/*:
 # Networking Wrapper
 
 Example of the use of the NetworkingWrapper using Alamofire
 
 ## Features
 
 * A way to cleary identify the Host and the related Endpoints
 * Custom configuration of each Host
 * Specify Path, HttpMethod and Encoding for each Endpoint
 * Easy set of Enviroments

Lets say we want to reach a media service that expose info about Movies and TV Shows
 
 https://www.themoviedb.org/documentation/api
 
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
 Now we define and interface for the movies expected Endpoints
 */
protocol MoviesEndpoints {
    static var nowPlaying : EndpointAlamofireImpl { get }
    static var popular : EndpointAlamofireImpl { get }
    static var topRated : EndpointAlamofireImpl { get }
    static var upcoming : EndpointAlamofireImpl { get }
}
/*:
 Then we define the service with the Host and the related Endpoints
 */
struct TheMovieDB {
    static let host = HostImpl(listRequest: [Environment.default : "https://api.themoviedb.org/3"])
    static let imgBaseURL =  "https://image.tmdb.org/t/p/w300"
    
    struct MovieEndpoint : MoviesEndpoints {}
    struct SeriesEndpoint { }
}
/*:
 Implement the Endpoints
 */
extension TheMovieDB.MovieEndpoint {
    static let nowPlaying = EndpointAlamofireImpl(path: "/movie/now_playing",
                                                  httpMethod: .get)
    static let popular = EndpointAlamofireImpl(path: "/movie/popular")
    static let topRated = EndpointAlamofireImpl(path: "/movie/top_rated")
    static let upcoming = EndpointAlamofireImpl(path: "/movie/upcoming")
}

extension TheMovieDB.SeriesEndpoint {
    static let airingToday = EndpointAlamofireImpl(path: "/tv/airing_today")
    static let onTheAir = EndpointAlamofireImpl(path: "/tv/on_the_air")
    static let popular = EndpointAlamofireImpl(path: "/tv/popular")
    static let topRated = EndpointAlamofireImpl(path: "/tv/top_rated")
}
/*:
 Test the service baseURL given the Environment and Endpoints Paths
 */
TheMovieDB.host.baseURL()
TheMovieDB.MovieEndpoint.topRated.path
TheMovieDB.SeriesEndpoint.topRated.path
/*:
 Now connect all together.
 Declare a NetworkRequest passing the Host and the Endpoind.
 */
let networkRequest = NetworkRequestAlamofireImpl(host: TheMovieDB.host,
                                                 endpoint: TheMovieDB.MovieEndpoint.nowPlaying,
                                                 parameters: ["api_key": "1f4d7de5836b788bdfd897c3e0d0a24b"])
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
