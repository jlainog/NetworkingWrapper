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
    associatedtype RequestLineType : RequestLine
    
    var host : HostType { get }
    var requestLine : RequestLineType { get }
    var parameters : [String : Any]? { get }
    var headers : [String : String]? { get }
    
    func absoluteURL() -> String
    func requestHeaders() -> [String : String]?
    func requestParams() -> [String : Any]?
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
    
    public func requestParams() -> [String : Any]? {
        var requestParams = Dictionary<String, Any>()
        
        if let hostParameters = host.parameters {
            for (key, value) in hostParameters {
                requestParams[key] = value
            }
        }
        
        if let parameters = self.parameters {
            for (key, value) in parameters {
                requestParams[key] = value
            }
        }
        
        return requestParams
    }
    
    public func absoluteURL() -> String {
        return host.baseURL() + requestLine.path
    }
}
