//
//  MatchedDetailInteractor.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 27/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

protocol MatchedDetailInteractor {
    func execute(userId: String, dogId: String, token: String,
                 onSuccess: @escaping (DogDecodable) -> Void,
                 onError: errorClosure)
}
