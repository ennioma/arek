//
//  ArekBaseLocation.swift
//  Arek
//
//  Created by Ennio Masi on 28/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import CoreLocation

class ArekBaseLocation: ArekBasePermission, ArekPermissionProtocol {
    var identifier: String = "ArekBaseLocation"
    var completion: ArekPermissionResponse? {
        willSet {
            locationDelegate = ArekBaseLocationDelegate(permission: self, completion: newValue!)
        }
    }
    var locationDelegate: ArekBaseLocationDelegate?
    
    override init() {
        super.init()
        super.permission = self
        
        self.initialPopupData = ArekPopupData(title: "Location service", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "Location service", message: "re enable 🙏")
    }
    
    required init(configuration: ArekConfiguration, initialPopupData: ArekPopupData?, reEnablePopupData: ArekPopupData?) {
        fatalError("init(configuration:initialPopupData:reEnablePopupData:) has not been implemented")
    }
    
    func manage(completion: @escaping ArekPermissionResponse) {
        self.status { (status) in
            self.managePermission(status: status, completion: completion)
        }
    }
    
    func status(completion: @escaping ArekPermissionResponse) {
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
        fatalError("askForPermission(configuration) has not been implemented")
    }
    
    func requestAlwaysAuthorization() {
        if let delegate = self.locationDelegate {
            delegate.locationManager.requestAlwaysAuthorization()
        }
    }
    
    func requestWhenInUseAuthorization() {
        if let delegate = self.locationDelegate {
            delegate.locationManager.requestWhenInUseAuthorization()
        }
    }
}
