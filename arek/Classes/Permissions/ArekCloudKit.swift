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

    public init() {
        super.init(initialPopupData: ArekPopupData(title: "I'm ☁️ discoverability", message: "enable"),
                   reEnablePopupData: ArekPopupData(title: "I'm ☁️ discoverability", message: "re enable 🙏"))
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        CKContainer.default().status(forApplicationPermission: CKApplicationPermissions.userDiscoverability, completionHandler: { applicationPermissionStatus, error in
            
            if let _ = error {
                return completion(.NotDetermined)
            }
            
            switch applicationPermissionStatus {
            case .granted:
                return completion(.Authorized)
            case .denied:
                return completion(.Denied)
            case .couldNotComplete:
                return completion(.NotDetermined)
            case .initialState:
                return completion(.NotDetermined)
            }
        })

    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        CKContainer.default().accountStatus { (accountStatus, error) in
            if let _ = error {
                print("[🚨 Arek 🚨] ☁️ accountStatus not determined 🤔 error: \(error)")
                return completion(.NotDetermined)
            }
            
            switch accountStatus {
            case .available, .restricted:
                CKContainer.default().requestApplicationPermission(CKApplicationPermissions.userDiscoverability,  completionHandler: { applicationPermissionStatus, error in
                    if let _ = error {
                        print("[🚨 Arek 🚨] ☁️ discoverability not determined 🤔 error: \(error)")
                        return completion(.NotDetermined)
                    }
                    switch applicationPermissionStatus {
                    case .denied:
                        print("[🚨 Arek 🚨] ☁️ discoverability denied by user ⛔️")
                        return completion(.Denied)
                    case .granted:
                        print("[🚨 Arek 🚨] ☁️ discoverability permission authorized by user ✅")
                        return completion(.Authorized)
                    case .couldNotComplete, .initialState:
                        return completion(.NotDetermined)
                    }
                })
            case .noAccount:
                print("[🚨 Arek 🚨] ☁️ account not configured ⛔️")
                return completion(.Denied)
            case .couldNotDetermine:
                print("[🚨 Arek 🚨] ☁️ account not determined 🤔")
                return completion(.NotDetermined)
            }
        }
    }
}
