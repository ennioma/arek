//
//  ArekBaseEvent.swift
//  Arek
//
//  Created by Ennio Masi on 30/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation

import EventKit

class ArekBaseEvent: ArekBasePermission, ArekPermissionProtocol {
    
    var identifier: String = "ArekBaseEvent"
    
    override init() {
        super.init()
        super.permission = self
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
        fatalError("status(configuration) has not been implemented")
    }
    
    func askForPermission(completion: @escaping ArekPermissionResponse) {
        fatalError("askForPermission(configuration) has not been implemented")
    }
}
