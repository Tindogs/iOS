//
//  LoginPresenter.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 26/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

protocol LoginView: class {
    var title: String? { get set }
}

final class LoginPresenter {
    
    weak var view: LoginView?
    
    func didLoad() {
        view?.title = "Login Form"
    }
}
