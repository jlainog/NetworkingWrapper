//
//  Endpoint.swift
//  NetworkingWrapper
//
//  Created by Jaime Laino on 1/7/17.
//  Copyright © 2017 Jaime Laino. All rights reserved.
//

public protocol RequestLine {
    associatedtype HttpMethod
    associatedtype ParameterEncoding
    
    var httpMethod : HttpMethod { get }
    var path : String { get }
    var encoding : ParameterEncoding { get }
}
