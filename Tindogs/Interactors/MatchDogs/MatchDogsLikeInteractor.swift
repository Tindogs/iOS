//
//  MatchDogsLikeInteractor.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 15/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

protocol MatchDogsLikeInteractor {
    func execute(userId: String, dogId: String, token: String, otherDogId: String, like: Bool,
                 onSuccess: @escaping (LikeDecodable) -> Void,
                 onError: errorClosure)
}
