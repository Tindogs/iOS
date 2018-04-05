//
//  RegisterAssembly.swift
//  Tindogs
//
//  Created by Fabio Gomez on 3/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation

import UIKit

final public class RegisterAssembly {
    
    private let webServiceAssembly: WebServiceAssembly
    
    init(webServiceAssembly: WebServiceAssembly) {
        self.webServiceAssembly = webServiceAssembly
    }
    
    public func viewController() -> UIViewController {
        return RegisterViewController(registerPresenter: presenter(), registerFormPresenter: registerFormPresenter())
    }
    
    func presenter() -> RegisterPresenter {
        return RegisterPresenter(repository: registerRepository())
    }
    
    func registerFormPresenter() -> RegisterFormPresenter {
        return RegisterFormPresenter()
    }
    
    func registerRepository() -> RegisterRepositoryProtocol {
        return RegisterRepository(webService: webServiceAssembly.webService)
    }
}
