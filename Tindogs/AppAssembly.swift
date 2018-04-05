//
//  AppAssembly.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 26/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit

final class AppAssembly {
    private(set) lazy var window = UIWindow(frame: UIScreen.main.bounds)
    private(set) lazy var navigationController = UINavigationController()
    private(set) lazy var coreAssembly = CoreAssembly(navigationController: navigationController)
}
