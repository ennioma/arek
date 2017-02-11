//  Arek
//
//  Created by Edwin Vermeer on 29/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import CoreBluetooth

open class ArekBluetooth: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekBluetooth"

    let bluetooth = ArekBluetoothDelegate()

    public init() {
        let data = ArekLocalizationManager(permission: self.identifier)
        
        super.init(initialPopupData: ArekPopupData(title: data.initialTitle, message: data.initialMessage, image: data.image),
                   reEnablePopupData: ArekPopupData(title: data.reEnableTitle, message:  data.reEnableMessage, image: data.image))
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        bluetooth.completion = completion
        
        switch CBPeripheralManager.authorizationStatus() {
        case .restricted, .denied:
            return completion(.denied)
        case .notDetermined, .authorized:
            switch bluetooth.bluetoothManager.state {
            case .unauthorized:
                return completion(.denied)
            case .poweredOn:
                return completion(.authorized)
            case .unsupported, .poweredOff, .resetting:
                return completion(.notAvailable)
            case .unknown:
                return completion(.notDetermined)
            }
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        bluetooth.completion = completion
        
        switch bluetooth.bluetoothManager.state {
        case .unsupported, .poweredOff, .resetting:
            print("[🚨 Arek 🚨] bluetooth not available 🚫")
            return completion(.notAvailable)
        case .unauthorized:
            print("[🚨 Arek 🚨] bluetooth not authorized by the user ⛔️")
            return completion(.denied)
        case .unknown:
            print("[🚨 Arek 🚨] bluetooth could not be determined 🤔")
            return completion(.notDetermined)
        case .poweredOn:
            bluetooth.bluetoothManager?.startAdvertising(nil)
            bluetooth.bluetoothManager?.stopAdvertising()
            break
        }
    }
}
