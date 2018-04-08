//
//  File.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 29/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

internal enum Endpoint {
    case authenticate(user: String, pass: String)
    case register(firstName: String, lastName: String, email: String, userName: String, password: String)
    
}

internal extension Endpoint {
    func request(with baseURL: URL) -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
//        var newParameters = self.parameters
//        parameters.forEach { newParameters.updateValue($1, forKey: $0) }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
//        components.queryItems = newParameters.map(URLQueryItem.init)
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        return request
    }
}

private enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put  = "PUT"
}

private extension Endpoint {
    var method: HTTPMethod {
        switch self {
        case .authenticate:
            return .post
        case .register:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .authenticate:
            return "users/authenticate/"
        case .register:
            return "users/register/"
        }
    }
            
    var parameters: [String: String] {
        switch self {
        case .authenticate:
            return [:]
        case .register:
            return [:]
        }
    }
    
    var body: [String: String] {
        switch self {
        case .authenticate(let user, let pass):
            return [
                "email": user,
                "password": pass
            ]
        case .register(let firstName, let lastName, let email, let userName, let password):
            return[
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "userName": userName,
                "password": password
            ]
        }
    }
}


