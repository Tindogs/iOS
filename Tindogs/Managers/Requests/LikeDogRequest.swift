//
//  LikeDogRequest.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 27/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

func LikeDogRequest(userId: String, dogId: String, token: String)  -> URLRequest {
    
    let url = URL(string: CONSTANTS.BASEURL + "users/\(userId)/dogs/\(dogId)")
    print("Url: \(String(describing: url))")
    var request = URLRequest(url:url!)
    
    request.httpMethod = Method.GET.rawValue
    request.addValue("application/json", forHTTPHeaderField: "content-type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    request.addValue(token, forHTTPHeaderField: "token")
    
    return request
}
