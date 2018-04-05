//
//  LoginRepository.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 31/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import RxSwift

protocol LoginRepositoryProtocol {
    func login(user: String, pass: String) -> Observable<User>
}

final class LoginRepository: LoginRepositoryProtocol {
    
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func login(user: String, pass: String) -> Observable<User> {
        return webService.load(User.self, from: .authenticate(user: user, pass: pass))
    }
    
}
