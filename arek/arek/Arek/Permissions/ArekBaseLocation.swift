//
//  ArekBaseLocation.swift
//  Arek
//
//  Created by Ennio Masi on 28/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import CoreLocation

class ArekBaseLocation: ArekPermissionProtocol {
    var permission: ArekPermission!
    var configuration: ArekConfiguration
    var identifier: String = "ArekBaseLocation"
    var initialPopupData: ArekPopupData = ArekPopupData(title: "I'm 📍", message: "enable")
    var reEnablePopupData: ArekPopupData = ArekPopupData(title: "I'm 📍", message: "re enable 🙏")

    let locationManager = CLLocationManager()
    
    init() {
        self.configuration = ArekConfiguration(frequency: .OnceADay, presentInitialPopup: false, presentReEnablePopup: true)
        self.permission = ArekPermission(permission: self)
    }
    
    required init(configuration: ArekConfiguration, initialPopupData: ArekPopupData?, reEnablePopupData: ArekPopupData?) {
        self.configuration = configuration
        self.permission = ArekPermission(permission: self)
        
        if let initialPopupData = initialPopupData {
            self.initialPopupData = initialPopupData
        }
        
        if let reEnablePopupData = reEnablePopupData {
            self.reEnablePopupData = reEnablePopupData
        }
    }
    
    func status(completion: ArekPermissionResponse) {
        guard CLLocationManager.locationServicesEnabled() else { return completion(.NotDetermined) }
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            return completion(.NotDetermined)
        case .restricted, .denied:
            return completion(.Denied)
        case .authorizedAlways, .authorizedWhenInUse:
            return completion(.Authorized)
        }
    }
    
    func askForPermission(completion: @escaping ArekPermissionResponse) {
        NSException(name:NSExceptionName(rawValue: "Don't call askForPermission directly EMLocation"), reason:"Implement always on the other one", userInfo:nil).raise()
    }
}
