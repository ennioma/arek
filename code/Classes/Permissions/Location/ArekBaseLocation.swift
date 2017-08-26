//
//  ArekBaseLocation.swift
//  Arek
//
//  Copyright (c) 2016 Ennio Masi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
    private var locationDelegate: ArekBaseLocationDelegate?
    
    public init() {
        super.init(identifier: self.identifier)
    }
    
    public override init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    public override init(configuration: ArekConfiguration? = nil, initialPopupData: ArekPopupData? = nil, reEnablePopupData: ArekPopupData? = nil) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
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
