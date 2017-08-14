//
//  AppDelegate.swift
//  SlideExample
//
//  Created by Tuan LE on 8/14/17.
//  Copyright © 2017 Leo LE. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = MainViewController(nibName: "MainViewController", bundle: nil)
        let navi = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navi
        self.window?.makeKeyAndVisible()
        return true
    }
}

