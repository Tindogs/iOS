//
//  ShowMatchesInteractor.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 24/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

protocol ShowMatchesInteractor {
    func execute(userId: String, dogId: String, token: String,
                 onSuccess: @escaping (MatchesDecodable) -> Void,
                 onError: errorClosure)
}
