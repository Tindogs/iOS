//
//  AppDelegate.swift
//  Tindogs
//
//  Created by Fco. Javier Guerrero Carmona on 1/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appAssembly = AppAssembly()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let initialViewController = appAssembly.coreAssembly.loginAssembly.viewController()
        
        appAssembly.window.rootViewController = appAssembly.navigationController
        appAssembly.navigationController.pushViewController(initialViewController, animated: false)
        appAssembly.window.makeKeyAndVisible()
        
        return true
    }
}

