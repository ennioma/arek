//
//  ArekNotifications.swift
//  arek
//
//  Created by Ennio Masi on 08/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation

import UIKit
import UserNotifications

public class ArekNotifications: ArekBasePermission, ArekPermissionProtocol {
    public var identifier: String = "ArekNotifications"
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "Push notifications service", message: "enable"),
                   reEnablePopupData: ArekPopupData(title: "Push notifications service", message: "re enable 🙏"))
    }
    
    public func status(completion: @escaping ArekPermissionResponse) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                switch settings.authorizationStatus {
                case .notDetermined:
                    return completion(.NotDetermined)
                case .denied:
                    return completion(.Denied)
                case .authorized:
                    return completion(.Authorized)
                }
            }
        } else if #available(iOS 9.0, *) {
            if let types = UIApplication.shared.currentUserNotificationSettings?.types {
                if types.isEmpty {
                    return completion(.NotDetermined)
                }
            }
            
            return completion(.Authorized)
        }
    }
        
    public func askForPermission(completion: @escaping ArekPermissionResponse) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { (granted, error) in
                if granted {
                    print("Push notifications permission authorized by user ✅")
                    return completion(.Authorized)
                }
                
                if let _ = error {
                    print("Push notifications permission not determined 🤔")
                    return completion(.NotDetermined)
                }
                
                print("Push notifications permission denied by user ⛔️")
                return completion(.Denied)
            }
        } else if #available(iOS 9.0, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}

