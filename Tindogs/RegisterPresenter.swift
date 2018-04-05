//
//  RegisterPresenter.swift
//  Tindogs
//
//  Created by Fabio Gomez on 3/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import RxSwift

protocol RegisterView: class {
    var title: String? { get set }
}

final class RegisterPresenter {
    private let repository: RegisterRepositoryProtocol
    private let disposeBag = DisposeBag()
    
    weak var view: RegisterView?
    
    init(repository: RegisterRepositoryProtocol){
        self.repository = repository
    }
    
    func didLoad() {
        view?.title = "Register Form"
    }
    
    func didSelect(firstName: String, lastName: String, email: String, userName: String, password: String) {
        let registerObservable = repository.register(firstName: firstName, lastName: lastName, email: email, userName: userName, password: password )
        registerObservable.subscribe(onNext: { user in
            print(user)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("Completed")
        }) {
            print("Disposed")
            }.disposed(by: disposeBag)
    }
    
}

