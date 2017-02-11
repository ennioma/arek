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
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "Access Location", message: "\(Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String) needs to access Location, do you want to proceed?", image: "arek_location_image"),
                   reEnablePopupData: ArekPopupData(title: "Access Location", message: "Please re-enable the access to the Location"))
    }

    public func status(completion: @escaping ArekPermissionResponse) {
        guard CLLocationManager.locationServicesEnabled() else { return completion(.notDetermined) }
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            return completion(.notDetermined)
        case .restricted, .denied:
            return completion(.denied)
        case .authorizedAlways, .authorizedWhenInUse:
            return completion(.authorized)
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
