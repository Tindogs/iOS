//
//  MatchDogsRequest.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 15/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

func MatchDogsRequest(userId: String, dogId: String, token: String)  -> URLRequest {
    let url = URL(string: CONSTANTS.BASEURL + "users/\(userId)/dogs/\(dogId)/search")
    print("Url: \(String(describing: url))")
    var request = URLRequest(url:url!)
    
    request.httpMethod = Method.GET.rawValue
    request.addValue("application/json", forHTTPHeaderField: "content-type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    request.addValue(token, forHTTPHeaderField: "token")
    
    return request
}

func MatchDogsLikeRequest(userId: String, dogId: String, token: String, otherDogId: String, like: Bool) -> URLRequest {
    let url = URL(string: CONSTANTS.BASEURL + "users/\(userId)/dogs/\(dogId)/like/\(otherDogId)")
    print("Url: \(String(describing: url))")
    var request = URLRequest(url:url!)
    
    request.httpMethod = Method.PUT.rawValue
    request.addValue("application/json", forHTTPHeaderField: "content-type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    request.addValue(token, forHTTPHeaderField: "token")
    
    let dictionary = ["like": like.description]
    
    print("like:: \(dictionary)")
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    }catch {
        print("Error: \(error)")
    }
    
    return request
}
