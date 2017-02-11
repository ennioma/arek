//
//  ArekReminders.swift
//  Arek
//
//  Created by Edwin Vermeer on 20/12/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import EventKit

open class ArekReminders: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekReminders"
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "Access Reminders", message: "\(Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String) needs to access your Reminders, do you want to proceed?", image: "arek_reminders_image"),
                   reEnablePopupData: ArekPopupData(title: "Access Reminders", message: "Please re-enable the access to the Reminders"))
    }

    open func status(completion: @escaping ArekPermissionResponse) {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
        case .authorized:
            return completion(.authorized)
        case .restricted, .denied:
            return completion(.denied)
        case .notDetermined:
            return completion(.notDetermined)
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        EKEventStore().requestAccess(to: .reminder) { granted, error in
            if let _ = error {
                print("[🚨 Arek 🚨] 🎗 permission error: \(error)")
                return completion(.notDetermined)
            }
            if granted {
                print("[🚨 Arek 🚨] 🎗 permission authorized by user ✅")
                return completion(.authorized)
            }
            print("[🚨 Arek 🚨] 🎗 permission denied by user ⛔️")
            return completion(.denied)
        }
    }
}
