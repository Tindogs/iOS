//
//  RegisterRepository.swift
//  Tindogs
//
//  Created by Fabio Gomez on 3/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import RxSwift

protocol RegisterRepositoryProtocol {
    func register(firstName: String, lastName: String, email: String, userName: String, password: String) -> Observable<User>
}


final class RegisterRepository: RegisterRepositoryProtocol {
    
    private let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func register(firstName: String, lastName: String, email: String, userName: String, password: String) -> Observable<User> {
        return webService.load(User.self, from: .register(firstName: firstName, lastName: lastName, email: email, userName: userName, password: password))
    }
    
}
