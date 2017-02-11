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
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "Access Camera", message: "\(Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String) needs to access your Camera, do you want to proceed?", image: "arek_camera_image"),
                   reEnablePopupData: ArekPopupData(title: "Access Camera", message: "Please re-enable the access to the Camera", image: "arek_camera_image"))
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
        case .notDetermined:
            return completion(.notDetermined)
        case .restricted, .denied:
            return completion(.denied)
        case .authorized:
            return completion(.authorized)
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (authorized) in
            if authorized {
                print("[🚨 Arek 🚨] 📷 permission authorized by user ✅")
                return completion(.authorized)
            }
            print("[🚨 Arek 🚨] 📷 permission denied by user ⛔️")
            return completion(.denied)
        }
    }
}
