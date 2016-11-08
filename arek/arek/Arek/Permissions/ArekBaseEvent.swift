//
//  ArekBaseEvent.swift
//  Arek
//
//  Created by Ennio Masi on 30/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation

import EventKit

class ArekBaseEvent: ArekPermissionProtocol {
    var permission: ArekPermission!
    var configuration: ArekConfiguration
    var identifier: String = "ArekBaseEvent"
    var initialPopupData: ArekPopupData = ArekPopupData(title: "I'm 📅", message: "enable")
    var reEnablePopupData: ArekPopupData = ArekPopupData(title: "I'm 📅", message: "re enable 🙏")

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
    
    func status(completion: @escaping ArekPermissionResponse) {
        NSException(name:NSExceptionName(rawValue: "Don't call status directly EMBaseEvent"), reason:"Implement always on the other one", userInfo:nil).raise()
    }
    
    func askForPermission(completion: @escaping ArekPermissionResponse) {
        NSException(name:NSExceptionName(rawValue: "Don't call askForPermission directly EMBaseEvent"), reason:"Implement always on the other one", userInfo:nil).raise()
    }
}
