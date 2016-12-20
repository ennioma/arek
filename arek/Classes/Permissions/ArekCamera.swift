//
//  ArekCamera.swift
//  Arek
//
//  Created by Ennio Masi on 29/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import AVFoundation

public class ArekCamera: ArekBasePermission, ArekPermissionProtocol {
    public var identifier: String = "ArekCamera"

    override public init() {
        super.init()
        self.permission = self
        self.initialPopupData = ArekPopupData(title: "I'm 📷", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "I'm 📷", message: "re enable 🙏")
    }
    
    required public init(configuration: ArekConfiguration, initialPopupData: ArekPopupData, reEnablePopupData: ArekPopupData) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
        super.permission = self
    }

    public func status(completion: @escaping ArekPermissionResponse) {
        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
        case .notDetermined:
            return completion(.NotDetermined)
        case .restricted, .denied:
            return completion(.Denied)
        case .authorized:
            return completion(.Authorized)
        }
    }
    
    public func manage(completion: @escaping ArekPermissionResponse) {
        self.status { (status) in
            self.managePermission(status: status, completion: completion)
        }
    }
    
    public func askForPermission(completion: @escaping ArekPermissionResponse) {
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
