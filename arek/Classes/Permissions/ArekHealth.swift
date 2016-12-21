//
//  ArekHealth.swift
//  Arek
//
//  Created by Ennio Masi on 07/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import HealthKit

public class ArekHealth: ArekBasePermission, ArekPermissionProtocol {
    
    public var identifier: String = "ArekHealth"
    
    var hkObjectType: HKObjectType?
    var hkSampleTypesToShare: Set<HKSampleType>?
    var hkSampleTypesToRead: Set<HKSampleType>?
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "I'm 📈", message: "enable"),
                   reEnablePopupData: ArekPopupData(title: "I'm 📈", message: "re enable 🙏"))
    }
    
    public func status(completion: @escaping ArekPermissionResponse) {
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
        
    public func askForPermission(completion: @escaping ArekPermissionResponse) {
        HKHealthStore().requestAuthorization(toShare: self.hkSampleTypesToShare, read: self.hkSampleTypesToRead) { (success, error) in
            if success {
                return completion(.Authorized)
            } else if let _ = error {
                return completion(.Denied)
            }
        }
    }
}
