//
//  AppDelegate.swift
//  Don't eat alone
//
//  Created by Louis Xia on 14/07/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: SigninViewController())
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

