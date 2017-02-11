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
        super.init(initialPopupData: ArekPopupData(title: "Access Photo Library", message: "\(Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String) needs to access your Photo Library, do you want to proceed?", image: "arek_camera_image"),
                   reEnablePopupData: ArekPopupData(title: "Access Photo Library", message: "Please re-enable the access to the Photo Library", image: "arek_camera_image"))
    }

    open func status(completion: @escaping ArekPermissionResponse) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            return completion(.notDetermined)
        case .restricted, .denied:
            return completion(.denied)
        case.authorized:
            return completion(.authorized)
        }
    }
        
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .notDetermined:
                print("[🚨 Arek 🚨] 🌅 permission not determined 🤔")
                return completion(.notDetermined)
            case .restricted, .denied:
                print("[🚨 Arek 🚨] 🌅 permission denied by user ⛔️")
                return completion(.denied)
            case.authorized:
                print("[🚨 Arek 🚨] 🌅 permission authorized by user ✅")
                return completion(.authorized)
            }
        }
    }
}

