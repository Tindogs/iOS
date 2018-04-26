//
//  MatchesDecodable.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 24/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

struct MatchesDecodable: Decodable {
    struct MatchesResponse: Decodable {
        let id_dog_matched: String
        let id_user_dog_matched: String?
        let name_dog_matched: String?
        let img_dog_matched: String
    }
    
    let result: [MatchesResponse]
    let succes: Bool?
}
