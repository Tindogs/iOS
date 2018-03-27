//
//  LoginViewController.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 26/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var loginFormView: UIView!
    

    // MARK: - Properties
    
    private let presenter: LoginPresenter
    private let loginFormPresenter: LoginFormPresenter
    
    // MARK: - Initialization
    
    init(loginPresenter: LoginPresenter, loginFormPresenter: LoginFormPresenter) {
        self.presenter = loginPresenter
        self.loginFormPresenter = loginFormPresenter
        
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self as? LoginView
        presenter.didLoad()
        loginFormView = LoginFormView.instantiate()
    }
    
    //Required by Swift
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
