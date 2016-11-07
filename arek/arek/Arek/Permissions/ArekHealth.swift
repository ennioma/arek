//
//  ArekHealth.swift
//  Arek
//
//  Created by Ennio Masi on 07/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import HealthKit

class ArekHealth: ArekPermissionProtocol {
    var permission: ArekPermission!
    var configuration: ArekConfiguration
    var identifier: String = "ArekHealth"
    var initialPopupData: ArekPopupData = ArekPopupData(title: "I'm 📈", message: "enable")
    var reEnablePopupData: ArekPopupData = ArekPopupData(title: "I'm 📈", message: "re enable 🙏")
    
    var hkObjectType: HKObjectType?
    var hkSampleTypesToShare: Set<HKSampleType>?
    var hkSampleTypesToRead: Set<HKSampleType>?
    
    init() {
        self.configuration = ArekConfiguration(frequency: .OnceADay, presentInitialPopup: false, presentReEnablePopup: true)
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
    
    func status(completion: (ArekPermissionStatus) -> Void) {
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
    
    func askForPermission(completion: @escaping ArekPermissionResponse) {
        HKHealthStore().requestAuthorization(toShare: self.hkSampleTypesToShare, read: self.hkSampleTypesToRead) { (success, error) in
            if success {
                return completion(.Authorized)
            } else if let _ = error {
                return completion(.Denied)
            }
        }
    }
}
