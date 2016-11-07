//
//  ArekCamera.swift
//  Arek
//
//  Created by Ennio Masi on 29/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import AVFoundation

class ArekCamera: ArekPermissionProtocol {
    var permission: ArekPermission!
    var configuration: ArekConfiguration
    var identifier: String = "ArekCamera"
    var initialPopupData: ArekPopupData = ArekPopupData(title: "I'm 📸", message: "enable")
    var reEnablePopupData: ArekPopupData = ArekPopupData(title: "I'm 📸", message: "re enable 🙏")
    
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

    func status(completion: ArekPermissionResponse) {
        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
        case .notDetermined:
            return completion(.NotDetermined)
        case .restricted, .denied:
            return completion(.Denied)
        case .authorized:
            return completion(.Authorized)
        }
    }
    
    func askForPermission(completion: @escaping ArekPermissionResponse) {
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (authorized) in
            if authorized {
                NSLog("📷 permission authorized by user ✅")
                return completion(.Authorized)
            } else {
                NSLog("📷 permission denied by user ⛔️")
                return completion(.Denied)
            }
        }
    }
}
