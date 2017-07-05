//
//  ArekCellVMServiceProgrammatically.swift
//  arek_example
//
//  Created by Ennio Masi on 05/07/2017.
//  Copyright © 2017 ennioma. All rights reserved.
//

import Foundation
import arek

class ArekCellVMServiceProgrammatically {
    static private var permissions = [
        ["popupDataTitle": "Media Library Access - native", "allowButtonTitle": "Allow 👍🏼", "denyButtonTitle": "No! 👎🏼", "enableTitle": "Please!", "reEnableTitle": "Re-enable please!"],
        ["popupDataTitle": "Camera Access - PMAlertController", "allowButtonTitle": "Allow 👍🏼", "denyButtonTitle": "No! 👎🏼", "enableTitle": "Please!", "reEnableTitle": "Re-enable please!"],
        ["popupDataTitle": "Location Always Access - native", "allowButtonTitle": "Allow 👍🏼", "denyButtonTitle": "No! 👎🏼", "enableTitle": "Please!", "reEnableTitle": "Re-enable please!"]
    ]
    
    static func numberOfVMs() -> Int {
        return self.permissions.count
    }
    
    static func buildVM(index: Int) -> ArekCellVM {
        let data = permissions[index]
        
        let configuration = ArekConfiguration(frequency: .OnceADay, presentInitialPopup: true, presentReEnablePopup: true)
        let initialPopupData = ArekPopupData(title: data["popupDataTitle"]!, message: data["enableTitle"]!, image: "", allowButtonTitle: data["allowButtonTitle"]!, denyButtonTitle: data["denyButtonTitle"]!, type: getPopuptType(index: index))
        let reenablePopupData = ArekPopupData(title: data["popupDataTitle"]!, message: data["reEnableTitle"]!, image: "", allowButtonTitle: data["allowButtonTitle"]!, denyButtonTitle: data["denyButtonTitle"]!, type: getPopuptType(index: index))
        
        let permission = getPermissionType(index: index, configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reenablePopupData)
        return ArekCellVM(permission: permission!, title: data["popupDataTitle"]!)
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
