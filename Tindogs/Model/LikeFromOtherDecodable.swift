//
//  LikeFromOtherDecodable.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 22/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

struct LikeFromOtherDecodable: Decodable {
    let _id: String
    let dog_like_id: String?
    let dog_name: String?
    let owner_id: String?
}
