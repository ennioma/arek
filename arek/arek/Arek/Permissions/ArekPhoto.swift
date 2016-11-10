//
//  ArekPhoto.swift
//  Arek
//
//  Created by Ennio Masi on 29/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import Photos

class ArekPhoto: ArekBasePermission, ArekPermissionProtocol {
    var identifier: String = "ArekPhoto"
    
    override init() {
        super.init()
        super.permission = self
        
        self.initialPopupData = ArekPopupData(title: "Photo service", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "Photo service", message: "re enable 🙏")
    }
    
    required init(configuration: ArekConfiguration, initialPopupData: ArekPopupData?, reEnablePopupData: ArekPopupData?) {
        fatalError("init(configuration:initialPopupData:reEnablePopupData:) has not been implemented")
    }
    
    func status(completion: @escaping ArekPermissionResponse) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            return completion(.NotDetermined)
        case .restricted, .denied:
            return completion(.Denied)
        case.authorized:
            return completion(.Authorized)
        }
    }
    
    func manage(completion: @escaping ArekPermissionResponse) {
        self.status { (status) in
            self.managePermission(status: status, completion: completion)
        }
    }
    
    func askForPermission(completion: @escaping ArekPermissionResponse) {
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
