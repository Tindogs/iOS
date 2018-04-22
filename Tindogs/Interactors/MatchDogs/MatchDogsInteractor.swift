//
//  MatchDogsInteractor.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 15/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

protocol MatchDogsInteractor {
    func execute(userId: String, dogId: String, token: String,
                 onSuccess: @escaping (DogDecodable) -> Void,
                 onError: errorClosure)
}
