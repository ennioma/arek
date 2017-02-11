//
//  ArekMediaLibrary.swift
//  Arek
//
//  Created by Edwin Vermeer on 20/12/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import MediaPlayer

open class ArekMediaLibrary: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekMediaLibrary"
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "Access Media Library", message: "\(Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String) needs to access your Media Library, do you want to proceed?", image: "arek_media_image"),
                   reEnablePopupData: ArekPopupData(title: "Access Media Library", message: "Please re-enable the access to the Media Library", image: "arek_media_image"))
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        if #available(iOS 9.3, *) {
            let status = MPMediaLibrary.authorizationStatus()
            switch status {
            case .authorized:
                return completion(.authorized)
            case .restricted, .denied:
                return completion(.denied)
            case .notDetermined:
                return completion(.notDetermined)
            }
        } else {
            return completion(.notAvailable)
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        if #available(iOS 9.3, *) {
            MPMediaLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    print("[🚨 Arek 🚨] 💽 permission authorized by user ✅")
                    return completion(.authorized)
                case .restricted, .denied:
                    print("[🚨 Arek 🚨] 💽 permission denied by user ⛔️")
                    return completion(.denied)
                case .notDetermined:
                    print("[🚨 Arek 🚨] 💽 permission not determined 🤔")
                    return completion(.notDetermined)
                }
            }
        } else {
            print("[🚨 Arek 🚨] 💽 permission denied by iOS ⛔️")
            return completion(.notAvailable)
        }
    }
}
