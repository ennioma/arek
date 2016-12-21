//
//  ArekEvents.swift
//  Arek
//
//  Created by Edwin Vermeer on 20/12/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import EventKit

open class ArekEvents: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekEvents"
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "I'm Events", message: "enable"),
                   reEnablePopupData: ArekPopupData(title: "I'm Events", message: "re enable 🙏"))
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
            let status = EKEventStore.authorizationStatus(for: .event)
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
            EKEventStore().requestAccess(to: .event) { _, error in
                if let _ = error {
                    print("Events permission not determined 🤔, error \(error)")
                    return completion(.NotDetermined)
                }
                
                let status = EKEventStore.authorizationStatus(for: .event)                
                switch status {
                case .authorized:
                    print("Events permission authorized by user ✅")
                    return completion(.Authorized)
                case .restricted, .denied:
                    print("Events permission denied by user ⛔️")
                    return completion(.Denied)
                case .notDetermined:
                    print("Events permission not determined 🤔")
                    return completion(.NotDetermined)
                }
            }
    }
}
