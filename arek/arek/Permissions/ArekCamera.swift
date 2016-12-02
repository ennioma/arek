//
//  ArekCamera.swift
//  Arek
//
//  Created by Ennio Masi on 29/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import AVFoundation

class ArekCamera: ArekBasePermission, ArekPermissionProtocol {
    var identifier: String = "ArekCamera"

    override init() {
        super.init()
        self.permission = self
        self.initialPopupData = ArekPopupData(title: "I'm 📷", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "I'm 📷", message: "re enable 🙏")
    }
    
    required init(configuration: ArekConfiguration, initialPopupData: ArekPopupData?, reEnablePopupData: ArekPopupData?) {
        super.init()
        self.permission = self
        self.configuration = configuration
        if let initialPopupData = initialPopupData {
            self.initialPopupData = initialPopupData
        }
        
        if let reEnablePopupData = reEnablePopupData {
            self.reEnablePopupData = reEnablePopupData
        }
    }
    
    func status(completion: @escaping ArekPermissionResponse) {
        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
        case .notDetermined:
            return completion(.NotDetermined)
        case .restricted, .denied:
            return completion(.Denied)
        case .authorized:
            return completion(.Authorized)
        }
    }
    
    func manage(completion: @escaping ArekPermissionResponse) {
        self.status { (status) in
            self.managePermission(status: status, completion: completion)
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
