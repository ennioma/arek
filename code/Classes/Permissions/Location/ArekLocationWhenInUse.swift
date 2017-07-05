//
//  ArekLocationWhenInUse.swift
//  Arek
//
//  Created by Ennio Masi on 30/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import CoreLocation

public class ArekLocationWhenInUse: ArekBaseLocation {
    override public init() {
        let identifier = "ArekLocationWhenInUse"
        super.init(identifier: identifier)
        
        self.identifier = identifier
    }
    
    public override init(configuration: ArekConfiguration? = nil,  initialPopupData: ArekPopupData? = nil, reEnablePopupData: ArekPopupData? = nil) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
        
        self.identifier = "ArekLocationWhenInUse"
    }
    
    override public func askForPermission(completion: @escaping ArekPermissionResponse) {
        self.completion = completion
        self.requestWhenInUseAuthorization()
    }
}
