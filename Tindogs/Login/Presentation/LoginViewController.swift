//
//  LoginViewController.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 26/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var loginFormView: UIView!
    

    // MARK: - Properties
    
    private let presenter: LoginPresenter
    private let loginFormPresenter: LoginFormPresenter
    private let disposeBag = DisposeBag()
    
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
        
        let loginFormViewInstance = LoginFormView.instantiate()
        
        loginFormViewInstance.tapGestureRecognizer.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.presenter.didSelect(user: loginFormViewInstance.userInput.text!, pass: loginFormViewInstance.passInput.text!)
            })
            .disposed(by: disposeBag)
        
        loginFormView.addSubview(loginFormViewInstance)
    }
    
    //Required by Swift
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
