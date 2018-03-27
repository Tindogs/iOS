//
//  LoginViewController.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 26/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    
    private let presenter: LoginPresenter
    
    // MARK: - Initialization
    
    init(loginPresenter: LoginPresenter) {
        self.presenter = loginPresenter
        
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    //Required by Swift
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self as? LoginView
        presenter.didLoad()
    }
}
