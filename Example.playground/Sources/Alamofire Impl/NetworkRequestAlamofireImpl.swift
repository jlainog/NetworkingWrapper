//
//  NetworkRequestAlamofireImpl.swift
//  NetworkingWrapper
//
//  Created by Jaime Laino on 1/7/17.
//  Copyright © 2017 Jaime Laino. All rights reserved.
//

import Foundation
import Alamofire

public struct NetworkRequestAlamofireImpl : NetworkRequest {
    public let host : HostImpl
    public let requestLine : RequestLineAlamofireImpl
    public let parameters : [String : Any]?
    public let headers : [String : String]?
    private let deserializerQueue = DispatchQueue.global()
    
    public init(host: HostImpl,
                resquestLine: RequestLineAlamofireImpl,
                parameters: [String : Any]? = nil,
                headers: [String : String]? = nil) {
        self.host = host
        self.requestLine = resquestLine
        self.parameters = parameters
        self.headers = headers
    }
    
    public func fire(response: @escaping (DataResponse<Any>) -> Void) {
        alamofireRequest()
            .responseJSON(queue: deserializerQueue) { alamofireResponse in
                DispatchQueue.main.async { response(alamofireResponse) }
        }
    }
    
    private func alamofireRequest() -> Alamofire.DataRequest {
        return Alamofire.request(absoluteURL(),
                                 method: requestLine.httpMethod,
                                 parameters: requestParams(),
                                 encoding: requestLine.encoding,
                                 headers: requestHeaders())
    }
}
