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

    override public init() {
        super.init()
        self.initialPopupData = ArekPopupData(title: "I'm ☁️ discoverability", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "I'm ☁️ discoverability", message: "re enable 🙏")
    }
        
    public func status(completion: @escaping ArekPermissionResponse) {
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
        
    public func askForPermission(completion: @escaping ArekPermissionResponse) {
        CKContainer.default().accountStatus { (accountStatus, error) in
            if let _ = error {
                print("☁️ discoverability permission error: \(error)")
                return completion(.NotDetermined)
            }
            switch accountStatus {
            case .available, .restricted:
                CKContainer.default().requestApplicationPermission(CKApplicationPermissions.userDiscoverability,  completionHandler: { applicationPermissionStatus, error in
                    if let _ = error {
                        print("☁️ discoverability permission error: \(error)")
                        return completion(.NotDetermined)
                    }
                    switch applicationPermissionStatus {
                    case .denied:
                        print("☁️ discoverability permission denied by user ⛔️")
                        return completion(.Denied)
                    case .granted:
                        print("☁️ discoverability permission authorized by user ✅")
                        return completion(.Authorized)
                    case .couldNotComplete, .initialState:
                        print("☁️ discoverability permission not determined 🤔")
                        return completion(.NotDetermined)
                    }
                })
            case .noAccount:
                print("☁️ discoverability permission no user account ⛔️")
                return completion(.Denied)
            case .couldNotDetermine:
                print("☁️ discoverability permission not determined 🤔")
                return completion(.NotDetermined)
            }
        }
    }
}
