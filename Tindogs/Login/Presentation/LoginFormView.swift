//
//  LoginFormView.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 27/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit

class LoginFormView: UIView, NibLoadableView {
    private enum Constants {
        static let height: CGFloat = 176
    }

    // MARK: - Outlets
    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: Constants.height)
    }

}
