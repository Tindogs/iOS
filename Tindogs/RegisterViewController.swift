//
//  RegisterViewController.swift
//  Tindogs
//
//  Created by Fabio Gomez on 3/4/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var registerFormView: UIView!
    
    
    // MARK: - Properties
    
    private let presenter: RegisterPresenter
    private let registerFormPresenter: RegisterFormPresenter
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    init(registerPresenter: RegisterPresenter, registerFormPresenter: RegisterFormPresenter) {
        self.presenter = registerPresenter
        self.registerFormPresenter = registerFormPresenter
        
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self as? RegisterView
        presenter.didLoad()
        
        let registerFormViewInstance = RegisterFormView.instantiate()
        
        registerFormViewInstance.tapGestureRecognizer.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.presenter.didSelect(
                    firstName: registerFormViewInstance.firstNameInput.text!, lastName: registerFormViewInstance.lastNameInput.text!, email: registerFormViewInstance.emailInput.text!, userName: registerFormViewInstance.userNameInput.text!, password: registerFormViewInstance.passwordInput.text!)
            })
            .disposed(by: disposeBag)
        
        registerFormView.addSubview(registerFormViewInstance)
    }
    
    //Required by Swift
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

