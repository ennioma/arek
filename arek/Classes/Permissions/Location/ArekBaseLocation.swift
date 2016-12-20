//
//  ArekBaseLocation.swift
//  Arek
//
//  Created by Ennio Masi on 28/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import CoreLocation

public class ArekBaseLocation: ArekBasePermission, ArekPermissionProtocol {
    public var identifier: String = "ArekBaseLocation"
    var completion: ArekPermissionResponse? {
        willSet {
            locationDelegate = ArekBaseLocationDelegate(permission: self, completion: newValue!)
        }
    }
    var locationDelegate: ArekBaseLocationDelegate?
    
    override public init() {
        super.init()
        self.initialPopupData = ArekPopupData(title: "I'm 🌍", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "I'm 🌍", message: "re enable 🙏")
    }
            
    public func status(completion: @escaping ArekPermissionResponse) {
        guard CLLocationManager.locationServicesEnabled() else { return completion(.NotDetermined) }
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("🌍 permission not determined 🤔")
            return completion(.NotDetermined)
        case .restricted, .denied:
            print("🌍 permission denied by user ⛔️")
            return completion(.Denied)
        case .authorizedAlways, .authorizedWhenInUse:
            print("🌍 permission authorized by user ✅")
            return completion(.Authorized)
        }
    }

    public func askForPermission(completion: @escaping ArekPermissionResponse) {
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
