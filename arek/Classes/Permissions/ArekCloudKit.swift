//
//  ArekCloudKit.swift
//  ExampleSourceCode
//
//  Created by Ennio Masi on 08/12/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import UIKit
import CloudKit

class ArekCloudKit: ArekBasePermission, ArekPermissionProtocol {
    public var identifier = "ArekCloudKit"

    override public init() {
        super.init()
        super.permission = self
        
        self.initialPopupData = ArekPopupData(title: "Contacs service", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "Contacts service", message: "re enable 🙏")
    }
    
    required public init(configuration: ArekConfiguration, initialPopupData: ArekPopupData, reEnablePopupData: ArekPopupData) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
        super.permission = self
    }
    
    func status(completion: @escaping ArekPermissionResponse) {
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
    
    func manage(completion: @escaping ArekPermissionResponse) {
        self.status { (status) in
            self.managePermission(status: status, completion: completion)
        }
    }
    
    func askForPermission(completion: @escaping ArekPermissionResponse) {
        CKContainer.default().accountStatus { (accountStatus, error) in
            if let _ = error {
                print("accountStatus error: \(error)")
                return completion(.NotDetermined)
            }
            switch accountStatus {
            case .available, .restricted:
                CKContainer.default().requestApplicationPermission(CKApplicationPermissions.userDiscoverability,  completionHandler: { applicationPermissionStatus, error in
                    if let _ = error {
                        return completion(.NotDetermined)
                    }
                    switch applicationPermissionStatus {
                    case .denied:
                        return completion(.Denied)
                    case .granted:
                        return completion(.Authorized)
                    case .couldNotComplete, .initialState:
                        return completion(.NotDetermined)
                    }
                })
            case .noAccount:
                return completion(.Denied)
            case .couldNotDetermine:
                return completion(.NotDetermined)
            }
        }
    }
}
