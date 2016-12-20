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
        super.permission = self
        
        self.initialPopupData = ArekPopupData(title: "Photo service", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "Photo service", message: "re enable 🙏")
    }
    
    required public init(configuration: ArekConfiguration, initialPopupData: ArekPopupData, reEnablePopupData: ArekPopupData) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
        super.permission = self
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
                return completion(.NotDetermined)
            case .restricted, .denied:
                return completion(.Denied)
            case.authorized:
                return completion(.Authorized)
            }
        }
    }
}
