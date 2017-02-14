//
//  ArekCloudKit.swift
//  ExampleSourceCode
//
//  Created by Ennio Masi on 08/12/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import UIKit
import CloudKit

open class ArekCloudKit: ArekBasePermission, ArekPermissionProtocol {
    open var identifier = "ArekCloudKit"

    public init(configuration: ArekConfiguration? = nil) {
        let data = ArekLocalizationManager(permission: self.identifier)
        
        super.init(configuration: configuration,
                   initialPopupData: ArekPopupData(title: data.initialTitle, message: data.initialMessage, image: data.image),
                   reEnablePopupData: ArekPopupData(title: data.reEnableTitle, message:  data.reEnableMessage, image: data.image))
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        CKContainer.default().status(forApplicationPermission: CKApplicationPermissions.userDiscoverability, completionHandler: { applicationPermissionStatus, error in
            
            if let _ = error {
                return completion(.notDetermined)
            }
            
            switch applicationPermissionStatus {
            case .granted:
                return completion(.authorized)
            case .denied:
                return completion(.denied)
            case .couldNotComplete:
                return completion(.notDetermined)
            case .initialState:
                return completion(.notDetermined)
            }
        })

    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        CKContainer.default().accountStatus { (accountStatus, error) in
            if let _ = error {
                print("[🚨 Arek 🚨] ☁️ accountStatus not determined 🤔 error: \(error)")
                return completion(.notDetermined)
            }
            
            switch accountStatus {
            case .available, .restricted:
                CKContainer.default().requestApplicationPermission(CKApplicationPermissions.userDiscoverability,  completionHandler: { applicationPermissionStatus, error in
                    if let _ = error {
                        print("[🚨 Arek 🚨] ☁️ discoverability not determined 🤔 error: \(error)")
                        return completion(.notDetermined)
                    }
                    switch applicationPermissionStatus {
                    case .denied:
                        print("[🚨 Arek 🚨] ☁️ discoverability denied by user ⛔️")
                        return completion(.denied)
                    case .granted:
                        print("[🚨 Arek 🚨] ☁️ discoverability permission authorized by user ✅")
                        return completion(.authorized)
                    case .couldNotComplete, .initialState:
                        return completion(.notDetermined)
                    }
                })
            case .noAccount:
                print("[🚨 Arek 🚨] ☁️ account not configured ⛔️")
                return completion(.denied)
            case .couldNotDetermine:
                print("[🚨 Arek 🚨] ☁️ account not determined 🤔")
                return completion(.notDetermined)
            }
        }
    }
}
