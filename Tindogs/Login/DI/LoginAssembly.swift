//
//  LoginAssembly.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 26/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit

final public class LoginAssembly {
    
    public func viewController() -> UIViewController {
        return LoginViewController(loginPresenter: presenter(), loginFormPresenter: loginFormPresenter())
    }
    
    func presenter() -> LoginPresenter {
        return LoginPresenter()
    }
    
    func loginFormPresenter() -> LoginFormPresenter {
        return LoginFormPresenter()
    }
}
