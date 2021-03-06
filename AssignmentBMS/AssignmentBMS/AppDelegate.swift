//
//  AppDelegate.swift
//  AssignmentBMS
//
//  Created by Ajay on 09/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRoot()
        return true
    }
    
    private func setRoot() {
        window = UIWindow()
        let moviesVC = MoviesModuleBuilder().buildModule()
        let navigationController = UINavigationController(rootViewController: moviesVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

