//
//  DogDecodable.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 15/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

struct DogDecodable: Decodable {
    struct DogResponse: Decodable {
        let _id: String
        let name: String?
        let age: Double?
        let purebreed: Bool?
        let likes_from_others: [LikeFromOtherDecodable]
        let description: String?
        let photos: [String]
    }
    
    let result: [DogResponse]
    let succes: Bool?
}
