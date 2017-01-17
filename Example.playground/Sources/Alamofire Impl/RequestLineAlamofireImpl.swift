//
//  RequestLineAlamofireImpl.swift
//  NetworkingWrapper
//
//  Created by Jaime Laino on 1/7/17.
//  Copyright © 2017 Jaime Laino. All rights reserved.
//

import Alamofire

public struct RequestLineAlamofireImpl: RequestLine {
    public let httpMethod : Alamofire.HTTPMethod
    public let path : String
    public let encoding : ParameterEncoding
    
    public init(path: String,
                httpMethod: Alamofire.HTTPMethod = .get,
                encoding : Alamofire.ParameterEncoding = URLEncoding.default) {
        self.path = path
        self.httpMethod = httpMethod
        self.encoding = encoding
    }
}
