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
                self?.presenter.didSelect(firstName: firstNameInput.text!, lastName: lastNameInput.text!, email: emailInput.text!, userName: userNameInput.text!, password: passwordInput.text!)
            })
            .disposed(by: disposeBag)
        
        RegisterFormView.addSubview(registerFormViewInstance)
    }
    
    //Required by Swift
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

