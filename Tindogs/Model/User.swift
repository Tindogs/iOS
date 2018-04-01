//
//  User.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 31/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

struct User: Decodable {
    let _id: String?
    let firstName: String
    let lastName: String
    let email: String
    let userName: String
    let password: String
    var coordinates : [Double]?
    var photo: String?
    var dogs : [Dog]?
    
    private enum CodingKeys: String, CodingKey {
        case _id
        case firstName
        case lastName
        case email
        case userName
        case password
        case coordinates
        case photo
        case dogs
    }
}
