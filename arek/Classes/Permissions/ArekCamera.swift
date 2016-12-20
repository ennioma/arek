//
//  ArekCamera.swift
//  Arek
//
//  Created by Ennio Masi on 29/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import AVFoundation

open class ArekCamera: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekCamera"

    override public init() {
        super.init()
        self.initialPopupData = ArekPopupData(title: "I'm 📷", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "I'm 📷", message: "re enable 🙏")
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
        case .notDetermined:
            return completion(.NotDetermined)
        case .restricted, .denied:
            return completion(.Denied)
        case .authorized:
            return completion(.Authorized)
        }
    }
        
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (authorized) in
            if authorized {
                print("📷 permission authorized by user ✅")
                return completion(.Authorized)
            } else {
                print("📷 permission denied by user ⛔️")
                return completion(.Denied)
            }
        }
    }
}
