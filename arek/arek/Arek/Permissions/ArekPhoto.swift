//
//  ArekPhoto.swift
//  Arek
//
//  Created by Ennio Masi on 29/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import Photos

class ArekPhoto: ArekPermissionProtocol {
    var permission: ArekPermission!
    var configuration: ArekConfiguration
    var identifier: String = "ArekPhoto"
    var initialPopupData: ArekPopupData = ArekPopupData(title: "I'm 📷", message: "enable")
    var reEnablePopupData: ArekPopupData = ArekPopupData(title: "I'm 📷", message: "re enable 🙏")
    
    init() {
        self.configuration = ArekConfiguration(frequency: .Always, presentInitialPopup: false, presentReEnablePopup: true)
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
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            return completion(.NotDetermined)
        case .restricted, .denied:
            return completion(.Denied)
        case.authorized:
            return completion(.Authorized)
        }
    }
    
    func askForPermission(completion: @escaping ArekPermissionResponse) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .notDetermined:
                return completion(.NotDetermined)
            case .restricted, .denied:
                return completion(.Denied)
            case.authorized:
                return completion(.Authorized)
            }
        }
    }
}
