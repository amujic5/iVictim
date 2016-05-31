//
//  AppDelegate.swift
//  iVictim
//
//  Created by Azzaro Mujic on 5/31/16
//  Copyright (c) 2016 . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow()
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let mainWireframe = MainWireframe(navigationController: navigationController)
        mainWireframe.showHomeScreen()
        
        return true
    }

}
