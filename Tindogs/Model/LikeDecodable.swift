//
//  LikeDecodable.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 25/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

struct LikeDecodable: Decodable {
    struct LikeResponse: Decodable {
        let match: Bool
    }
    
    let result: LikeResponse?
    let success: Bool
}
