//
//  ArekBaseLocationDelegate.swift
//  arek
//
//  Created by Ennio Masi on 10/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import CoreLocation

public class ArekBaseLocationDelegate: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager = CLLocationManager()
    var completion: ArekPermissionResponse?
    var permission: ArekPermissionProtocol?
    
    public init(permission: ArekPermissionProtocol, completion: @escaping ArekPermissionResponse) {
        super.init()
        self.completion = completion
        self.permission = permission
        self.locationManager.delegate = self
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if let permission = self.permission {
            permission.status(completion: { (status) in
                if let completion = self.completion {
                    completion(status)
                }
            })
        }
    }
}
