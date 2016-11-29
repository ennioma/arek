//
//  AppDelegate.swift
//  Arek
//
//  Created by Ennio Masi on 30/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = DemoViewController()
        window.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        
        self.window = window

        return true
    }
    
    private func setupWatchdog() {
        #if DEBUG
//            self.watchdog = Watchdog(threshold: 0.4, strictMode: false)
        #endif
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

