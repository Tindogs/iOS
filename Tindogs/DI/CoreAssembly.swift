//
//  CoreAssembly.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 26/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit

final public class CoreAssembly {
    
    public private(set) lazy var loginAssembly = LoginAssembly()
    
    public let navigationController: UINavigationController
    
    public init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
