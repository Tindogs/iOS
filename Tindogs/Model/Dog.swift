//
//  Dog.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 31/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

struct Dog: Decodable {
    let _id: String
    let name: String?
    let age: Int?
    let purebreed: Bool?
    let likes_from_others: [String]
    let description: String?
    let photos: [String]

}
