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
    var rootVC: DemoViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.rootVC = DemoViewController()
        window.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
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
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        if #available(iOS 9.0, *) {
            ArekNotifications().status { (status) in
                switch status {
                case .NotDetermined:
                    NSLog("⁉️Current Permission NotDetermined")
                    break
                case .Denied:
                    NSLog("⛔️Current Permission Denied")
                case .Authorized:
                    NSLog("✅Current Permission Authorized")
                }
            }
            
            self.rootVC?.permissionsTV.reloadData()
        }
    }
}

