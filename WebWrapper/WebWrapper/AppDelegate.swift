//
//  AppDelegate.swift
//  WebWrapper
//
//  Created by Orlando G. Rodriguez on 12/1/18.
//  Copyright © 2018 orlandogrodriguez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Programatically create the first VC and nav controller
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.isNavigationBarHidden = false
        mainViewController.view.backgroundColor = UIColor.white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

