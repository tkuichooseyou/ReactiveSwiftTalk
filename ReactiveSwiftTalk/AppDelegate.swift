//
//  AppDelegate.swift
//  ReactiveSwiftTalk
//
//  Created by Teddy Ku on 1/20/17.
//  Copyright © 2017 Teddy Ku. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    var rootViewController: UIViewController? {
        return window?.rootViewController
    }

    let rootNavController: UINavigationController = {
        let vc = ViewController()
        return UINavigationController(rootViewController: vc)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        URLCache.shared = URLCache(memoryCapacity: 20 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: nil)

        window?.rootViewController = rootNavController
        window?.makeKeyAndVisible()
        return true
    }

}

