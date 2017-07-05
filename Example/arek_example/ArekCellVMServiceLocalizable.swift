//
//  ArekCellVMServiceLocalizable.swift
//  arek_example
//
//  Created by Ennio Masi on 05/07/2017.
//  Copyright © 2017 ennioma. All rights reserved.
//

import Foundation
import arek

struct LocalizableData {
    var permission: ArekPermissionProtocol
    var title: String
}

class ArekCellVMServiceLocalizable {
    static private var permissions = [
        LocalizableData(permission: ArekContacts(), title: "Access Contacts - PMAlertController"),
        LocalizableData(permission: ArekPhoto(), title: "Access Photo - PMAlertController"),
        LocalizableData(permission: ArekReminders(), title: "Access Reminders - PMAlertController")
    ]
    
    static func numberOfVMs() -> Int {
        return self.permissions.count
    }
    
    static func buildVM(index: Int) -> ArekCellVM {
        let permission = permissions[index]
        
        return ArekCellVM(permission: permission.permission, title: permission.title)
    }
    
    static private func getPermissionType(index: Int, configuration: ArekConfiguration, initialPopupData: ArekPopupData, reEnablePopupData: ArekPopupData) -> ArekPermissionProtocol? {
        
        switch index {
        case 0:
            return ArekMediaLibrary(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
        case 1:
            return ArekCamera(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
        case 2:
            return ArekLocationAlways(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
        default:
            return nil
        }
    }
}
