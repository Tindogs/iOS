//
//  LoginFormView.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 27/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit

final class LoginFormView: UIView, NibLoadableView {
    private enum Constants {
        static let height: CGFloat = 280
    }

    // MARK: - Outlets
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: Constants.height)
    }

}
