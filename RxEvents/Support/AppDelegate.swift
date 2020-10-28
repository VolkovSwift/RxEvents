//
//  AppDelegate.swift
//  RxEvents
//
//  Created by Uladzislau Volkau on 10/26/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
                    return true
                }
        
        let container = DependencyContainer()
        
        let bounds = UIScreen.main.bounds
        window = UIWindow(frame: bounds)
        window?.makeKeyAndVisible()
        
        window?.rootViewController = container.makeMainTabBarController()
        
        return true
    }
}

