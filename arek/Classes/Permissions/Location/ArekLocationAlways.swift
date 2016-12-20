//
//  ArekLocationAlways.swift
//  Arek
//
//  Created by Ennio Masi on 30/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import CoreLocation

public class ArekLocationAlways: ArekBaseLocation {
    
    override public init() {
        super.init()
        
        self.identifier = "ArekLocationAlways"
    }
    
    required public init(configuration: ArekConfiguration, initialPopupData: ArekPopupData, reEnablePopupData: ArekPopupData) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

    override public func askForPermission(completion: @escaping ArekPermissionResponse) {
        self.completion = completion
        self.requestAlwaysAuthorization()
    }
}
