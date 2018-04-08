//
//  LoginPresenter.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 26/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import RxSwift

protocol LoginView: class {
    var title: String? { get set }
}

final class LoginPresenter {
    private let repository: LoginRepositoryProtocol
    private let disposeBag = DisposeBag()
    
    weak var view: LoginView?
    
    init(repository: LoginRepositoryProtocol){
        self.repository = repository
    }
    
    func didLoad() {
        view?.title = "Login Form"
    }
    
    func didSelect(user: String, pass: String) {
        let loginObsevable = repository.login(user: user, pass: pass)
        loginObsevable.subscribe(onNext: { user in
            print("user: \(user)")
//            print("user: \(user.result.first_name)")
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("Completed")
        }) {
            print("Disposed")
        }.disposed(by: disposeBag)
    }
        
}
