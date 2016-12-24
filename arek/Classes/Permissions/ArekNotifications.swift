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

open class ArekNotifications: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekNotifications"
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "Push notifications service", message: "enable"),
                   reEnablePopupData: ArekPopupData(title: "Push notifications service", message: "re enable 🙏"))
    }

    open func status(completion: @escaping ArekPermissionResponse) {
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
        
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { (granted, error) in
                if let _ = error {
                    print("[🚨 Arek 🚨] Push notifications permission not determined 🤔, error: \(error)")
                    return completion(.NotDetermined)
                }
                if granted {
                    print("[🚨 Arek 🚨] Push notifications permission authorized by user ✅")
                    return completion(.Authorized)
                }
                print("[🚨 Arek 🚨] Push notifications permission denied by user ⛔️")
                return completion(.Denied)
            }
        } else if #available(iOS 9.0, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}

