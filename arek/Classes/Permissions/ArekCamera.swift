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
        let data = ArekLocalizationManager(permission: self.identifier)
        
        super.init(initialPopupData: ArekPopupData(title: data.initialTitle, message: data.initialMessage, image: data.image),
                   reEnablePopupData: ArekPopupData(title: data.reEnableTitle, message:  data.reEnableMessage, image: data.image))
    }
    
    public override init(configuration: ArekConfiguration? = nil,  initialPopupData: ArekPopupData? = nil, reEnablePopupData: ArekPopupData? = nil) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
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
