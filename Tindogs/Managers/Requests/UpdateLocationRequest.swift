//
//  UpdateLocationRequest.swift
//  Tindogs
//
//  Created by Fabio Gomez on 26/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//


import Foundation

func updateLocationRequest(userId: String, token: String, coordinates: [Double]) -> URLRequest {
    
    let url = URL(string: CONSTANTS.BASEURL + EndPoints.findOrUpdateUser.rawValue + userId)
    var request = URLRequest (url:url!)
    
    request.httpMethod = Method.PUT.rawValue
    request.addValue("application/json", forHTTPHeaderField: "content-type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue(token, forHTTPHeaderField: CONSTANTS.userDefaultsToken)
    
    let dictionary = ["coordinates": coordinates] as [String: Any]
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    } catch {
        print("💩 Error serializing dictionary")
    }
    
    return request
}

