//
//  URLRequest.swift
//  NetworkingWrapper
//
//  Created by Jaime Laino on 1/7/17.
//  Copyright © 2017 Jaime Laino. All rights reserved.
//

public protocol URLRequestConvertible {
    var urlRequest: URLRequest { get }
}

public protocol URLRequest : URLRequestConvertible {
    var url : String { get }
}

extension URLRequest {
    var urlRequest: URLRequest {
        return self
    }
}

struct URLRequestImpl : URLRequest {
    let url : String
}

extension String: URLRequestConvertible {
    public var urlRequest: URLRequest {
        return URLRequestImpl(url: self)
    }
}
