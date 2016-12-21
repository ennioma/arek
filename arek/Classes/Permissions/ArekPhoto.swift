//
//  ArekPhoto.swift
//  Arek
//
//  Created by Ennio Masi on 29/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import Photos

open class ArekPhoto: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekPhoto"
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "I'm 🌅", message: "enable"),
                   reEnablePopupData: ArekPopupData(title: "I'm 🌅", message: "re enable 🙏"))
    }

    open func status(completion: @escaping ArekPermissionResponse) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            return completion(.NotDetermined)
        case .restricted, .denied:
            return completion(.Denied)
        case.authorized:
            return completion(.Authorized)
        }
    }
        
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .notDetermined:
                print("[🚨 Arek 🚨] 🌅 permission not determined 🤔")
                return completion(.NotDetermined)
            case .restricted, .denied:
                print("[🚨 Arek 🚨] 🌅 permission denied by user ⛔️")
                return completion(.Denied)
            case.authorized:
                print("[🚨 Arek 🚨] 🌅 permission authorized by user ✅")
                return completion(.Authorized)
            }
        }
    }
}

