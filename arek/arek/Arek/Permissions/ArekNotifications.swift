//
//  ArekNotifications.swift
//  arek
//
//  Created by Ennio Masi on 08/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import UserNotifications

class ArekNotifications: ArekPermissionProtocol {
    var permission: ArekPermission!
    var configuration: ArekConfiguration
    var identifier: String = "ArekNotifications"
    var initialPopupData: ArekPopupData = ArekPopupData(title: "I'm 📷", message: "enable")
    var reEnablePopupData: ArekPopupData = ArekPopupData(title: "I'm 📷", message: "re enable 🙏")
    
    var notificationOptions: UNAuthorizationOptions = [.alert, .badge]
    
    init() {
        self.configuration = ArekConfiguration(frequency: .Always, presentInitialPopup: false, presentReEnablePopup: true)
        self.permission = ArekPermission(permission: self)
    }
    
    required init(configuration: ArekConfiguration, initialPopupData: ArekPopupData?, reEnablePopupData: ArekPopupData?) {
        self.configuration = configuration
        self.permission = ArekPermission(permission: self)
        
        if let initialPopupData = initialPopupData {
            self.initialPopupData = initialPopupData
        }
        
        if let reEnablePopupData = reEnablePopupData {
            self.reEnablePopupData = reEnablePopupData
        }
    }
    
    func status(completion: @escaping ArekPermissionResponse) {
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
    }
    
    func askForPermission(completion: @escaping ArekPermissionResponse) {
        UNUserNotificationCenter.current().requestAuthorization(options: notificationOptions) { (granted, error) in
            if granted {
                return completion(.Authorized)
            }
            
            if let _ = error {
                return completion(.NotDetermined)
            }
            
            return completion(.Denied)
        }
    }
}
