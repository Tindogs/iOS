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
    let name: String
    var age: Int
    var breed: String
    var pureBreed: Bool
    var color: String
    var likesFromOthers: [String]
    var description: String
    var photos: [String]
    
    private enum CodingKeys: String, CodingKey {
        case _id
        case name
        case age
        case breed
        case pureBreed
        case color
        case likesFromOthers
        case description
        case photos
    }
}
