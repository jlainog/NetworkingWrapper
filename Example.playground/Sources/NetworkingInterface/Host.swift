//
//  Host.swift
//  NetworkingWrapper
//
//  Created by Jaime Laino on 1/7/17.
//  Copyright © 2017 Jaime Laino. All rights reserved.
//

public protocol Host {
    associatedtype Environment : Hashable
    
    var headers: [String : String]? { get }
    var environment : Environment { get }
    var listRequest : [Environment : URLRequestConvertible] { get }
    func baseURL() -> String!
}

extension Host {
    public func baseURL() -> String! {
        return request().url
    }
    
    private func request() -> URLRequest! {
        guard let request = listRequest[environment] else {
            assert(true, "add request for environment: \(environment)")
            return nil
        }
        
        return request.urlRequest
    }
}
