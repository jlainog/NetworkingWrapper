//
//  HostImpl.swift
//  NetworkingWrapper
//
//  Created by Jaime Laino on 1/7/17.
//  Copyright © 2017 Jaime Laino. All rights reserved.
//

public enum Environment {
    case dev, prod
    
    public static var `default`: Environment { return .dev }
}

public struct HostImpl : Host {
    public let listRequest: [Environment : URLRequestConvertible]
    public let headers: [String : String]?
    public var environment: Environment {
//        User your Settings or Build Variables to assign the enviroment
//        return Settings.sharedInstance.selectedEnvironment
        return .default
    }
    
    public init(listRequest: [Environment : URLRequestConvertible],
         headers: [String : String]? = nil) {
        self.listRequest = listRequest
        self.headers = headers
    }
}
