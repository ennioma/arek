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
    
    override public init() {
        super.init()
        super.permission = self
        
        self.initialPopupData = ArekPopupData(title: "I'm 📈", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "I'm 📈", message: "re enable 🙏")
    }
    
    required public init(configuration: ArekConfiguration, initialPopupData: ArekPopupData, reEnablePopupData: ArekPopupData) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
        super.permission = self
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
    
    public func manage(completion: @escaping ArekPermissionResponse) {
        self.status { (status) in
            self.managePermission(status: status, completion: completion)
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
