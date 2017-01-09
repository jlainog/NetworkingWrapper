//
//  NetworkRequest.swift
//  NetworkingWrapper
//
//  Created by Jaime Laino on 1/7/17.
//  Copyright © 2017 Jaime Laino. All rights reserved.
//

import Foundation

public protocol NetworkRequest {
    associatedtype NetworkResponse
    associatedtype HostType : Host
    associatedtype EndpointType : Endpoint
    
    var host : HostType { get }
    var endpoint : EndpointType { get }
    var parameters : [String : Any]? { get }
    var headers : [String : String]? { get }
    
    func absoluteURL() -> String
    func requestHeaders() -> [String : String]?
    func fire(response:NetworkResponse)
}

extension NetworkRequest {
    public func requestHeaders() -> [String : String]? {
        var requestHeaders = Dictionary<String, String>()
        
        if let hostHeaders = host.headers {
            for (key, value) in hostHeaders {
                requestHeaders[key] = value
            }
        }
        
        if let headers = self.headers {
            for (key, value) in headers {
                requestHeaders[key] = value
            }
        }
        
        return requestHeaders
    }
    
    public func absoluteURL() -> String {
        return host.baseURL() + endpoint.path
    }
}
