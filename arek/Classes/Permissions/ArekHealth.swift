//
//  ArekHealth.swift
//  Arek
//
//  Created by Ennio Masi on 07/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import HealthKit

open class ArekHealth: ArekBasePermission, ArekPermissionProtocol {
    
    public var identifier: String = "ArekHealth"
    
    var hkObjectType: HKObjectType?
    var hkSampleTypesToShare: Set<HKSampleType>?
    var hkSampleTypesToRead: Set<HKSampleType>?
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "I'm 📈", message: "enable"),
                   reEnablePopupData: ArekPopupData(title: "I'm 📈", message: "re enable 🙏"))
    }

    open func status(completion: @escaping ArekPermissionResponse) {
        guard let objectType = self.hkObjectType else {
            return completion(.NotDetermined)
        }
        
        switch HKHealthStore().authorizationStatus(for: objectType) {
        case .notDetermined:
            return completion(.NotDetermined)
        case .sharingDenied:
            return completion(.Denied)
        case .sharingAuthorized:
            return completion(.Authorized)
        }
    }
        
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        if self.hkSampleTypesToRead == nil && self.hkSampleTypesToShare == nil {
            print("[🚨 Arek 🚨] 📈 no permissions specified 🤔")
            return completion(.NotDetermined)
        }
        HKHealthStore().requestAuthorization(toShare: self.hkSampleTypesToShare, read: self.hkSampleTypesToRead) { (granted, error) in
            if let _ = error {
                print("[🚨 Arek 🚨] 📈 permission not determined 🤔 error: \(error)")
                return completion(.NotDetermined)
            }
            
            if granted {
                print("[🚨 Arek 🚨] 📈 permission authorized by user ✅")
                return completion(.Authorized)
            }
            print("[🚨 Arek 🚨] 📈 permission denied by user ⛔️")
            return completion(.Denied)
        }
    }
}
