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
    
    override public init() {
        super.init()
        self.initialPopupData = ArekPopupData(title: "I'm 🎗", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "I'm 🎗", message: "re enable 🙏")
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
        case .authorized:
            return completion(.Authorized)
        case .restricted, .denied:
            return completion(.Denied)
        case .notDetermined:
            return completion(.NotDetermined)
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        EKEventStore().requestAccess(to: .reminder) { allowed, error in
            if let _ = error {
                print("🎗 permission error: \(error)")
                return completion(.NotDetermined)
            }
            
            let status = EKEventStore.authorizationStatus(for: .reminder)
            switch status {
            case .authorized:
                print("🎗 permission authorized by user ✅")
                return completion(.Authorized)
            case .restricted, .denied:
                print("🎗 permission denied by user ⛔️")
                return completion(.Denied)
            case .notDetermined:
                print("🎗 permission not determined 🤔")
                return completion(.NotDetermined)
            }
        }
    }
}
