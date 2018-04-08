//
//  User.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 31/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

struct User: Decodable {
    struct UserResponse: Decodable {
        let _id: String?
        let first_name: String
        let last_name: String
        let email: String
        let username: String
        let password: String
        let coordinates : [Double]?
        let photo: String?
        let dogs : [Dog]?
    }
    
    let result: UserResponse
    
}
