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
        super.init(initialPopupData: ArekPopupData(title: "Access HealthKit", message: "\(Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String) needs to access HealthKit, do you want to proceed?", image: "arek_health_image"),
                   reEnablePopupData: ArekPopupData(title: "Access HealthKit", message: "Please re-enable the access to the HealthKit"))
    }

    open func status(completion: @escaping ArekPermissionResponse) {
        guard let objectType = self.hkObjectType else {
            return completion(.notDetermined)
        }
        
        switch HKHealthStore().authorizationStatus(for: objectType) {
        case .notDetermined:
            return completion(.notDetermined)
        case .sharingDenied:
            return completion(.denied)
        case .sharingAuthorized:
            return completion(.authorized)
        }
    }
        
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        if self.hkSampleTypesToRead == nil && self.hkSampleTypesToShare == nil {
            print("[🚨 Arek 🚨] 📈 no permissions specified 🤔")
            return completion(.notDetermined)
        }
        HKHealthStore().requestAuthorization(toShare: self.hkSampleTypesToShare, read: self.hkSampleTypesToRead) { (granted, error) in
            if let _ = error {
                print("[🚨 Arek 🚨] 📈 permission not determined 🤔 error: \(error)")
                return completion(.notDetermined)
            }
            
            if granted {
                print("[🚨 Arek 🚨] 📈 permission authorized by user ✅")
                return completion(.authorized)
            }
            print("[🚨 Arek 🚨] 📈 permission denied by user ⛔️")
            return completion(.denied)
        }
    }
}
