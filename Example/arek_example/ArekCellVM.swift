//
//  ArekCellVM.swift
//  arek_example
//
//  Created by Masi, Ennio (Senior iOS Developer) on 05/07/2017.
//  Copyright © 2017 ennioma. All rights reserved.
//

import Foundation

import arek

class ArekCellVMService {
    static private var permissions = [
        ["popupDataTitle": "Media Library Access - native", "allowButtonTitle": "Allow 👍🏼", "denyButtonTitle": "No! 👎🏼", "enableTitle": "Please!", "reEnableTitle": "Re-enable please!"],
        ["popupDataTitle": "Camera Access - PMAlertController", "allowButtonTitle": "Allow 👍🏼", "denyButtonTitle": "No! 👎🏼", "enableTitle": "Please!", "reEnableTitle": "Re-enable please!"],
        ["popupDataTitle": "Location Always Access - native", "allowButtonTitle": "Allow 👍🏼", "denyButtonTitle": "No! 👎🏼", "enableTitle": "Please!", "reEnableTitle": "Re-enable please!"]
    ]
    
    static func numberOfVMs() -> Int {
        return self.permissions.count
    }
    
    static func buildVM(index: Int) -> ArekCellVM {
        if index < permissions.count {
            let data = permissions[index]
            
            let configuration = ArekConfiguration(frequency: .OnceADay, presentInitialPopup: true, presentReEnablePopup: true)
            let initialPopupData = ArekPopupData(title: data["popupDataTitle"]!, message: data["enableTitle"]!, image: "", allowButtonTitle: data["allowButtonTitle"]!, denyButtonTitle: data["denyButtonTitle"]!, type: getPopuptType(index: index))
            let reenablePopupData = ArekPopupData(title: data["popupDataTitle"]!, message: data["reEnableTitle"]!, image: "", allowButtonTitle: data["allowButtonTitle"]!, denyButtonTitle: data["denyButtonTitle"]!, type: getPopuptType(index: index))
            
            let permission = getPermissionType(index: index, configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reenablePopupData)
            return ArekCellVM(permission: permission!, title: data["popupDataTitle"]!)
        } else {
            return ArekCellVM(permission: giveMeContacts(), title: "Contacts access")
        }
    }
    
    static private func getPopuptType(index: Int) -> ArekPopupType {
        switch index {
        case 0:
            return .native
        case 1:
            return .codeido
        case 2:
            return .native
        default:
            return .native
        }
    }
    
    static private func giveMeContacts() -> ArekPermissionProtocol {
        return ArekContacts()
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

class ArekCellVM {
    private(set) var permission: ArekPermissionProtocol
    private(set) var title: String
    
    init(permission: ArekPermissionProtocol, title: String) {
        self.permission = permission
        self.title = title
    }
}
