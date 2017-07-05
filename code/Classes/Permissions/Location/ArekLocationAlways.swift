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
        let identifier = "ArekLocationAlways"
        super.init(identifier: identifier)
        
        self.identifier = identifier
    }
    
    public override init(configuration: ArekConfiguration? = nil,  initialPopupData: ArekPopupData? = nil, reEnablePopupData: ArekPopupData? = nil) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
        
        self.identifier = "ArekLocationAlways"
    }
    
    override public func askForPermission(completion: @escaping ArekPermissionResponse) {
        self.completion = completion
        self.requestAlwaysAuthorization()
    }
}
