//
//  ArekPhoto.swift
//  Arek
//
//  Created by Ennio Masi on 29/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import Photos

public class ArekPhoto: ArekBasePermission, ArekPermissionProtocol {
    public var identifier: String = "ArekPhoto"
    
    override public init() {
        super.init()
        
        self.initialPopupData = ArekPopupData(title: "I'm 🌅", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "I'm 🌅", message: "re enable 🙏")
    }
        
    public func status(completion: @escaping ArekPermissionResponse) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            return completion(.NotDetermined)
        case .restricted, .denied:
            return completion(.Denied)
        case.authorized:
            return completion(.Authorized)
        }
    }
        
    public func askForPermission(completion: @escaping ArekPermissionResponse) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .notDetermined:
                print("🌅 permission not determined 🤔")
                return completion(.NotDetermined)
            case .restricted, .denied:
                print("🌅 permission denied by user ⛔️")
                return completion(.Denied)
            case.authorized:
                print("🌅 permission authorized by user ✅")
                return completion(.Authorized)
            }
        }
    }
}

