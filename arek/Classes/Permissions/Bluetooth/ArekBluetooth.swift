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
        super.init(initialPopupData: ArekPopupData(title: "I'm bluetooth", message: "enable"),
                   reEnablePopupData: ArekPopupData(title: "I' bluetooth", message: "re enable 🙏"))
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        bluetooth.completion = completion
        
        switch CBPeripheralManager.authorizationStatus() {
        case .restricted, .denied:
            return completion(.Denied)
        case .notDetermined, .authorized:
            switch bluetooth.bluetoothManager.state {
            case .unauthorized:
                return completion(.Denied)
            case .poweredOn:
                return completion(.Authorized)
            case .unsupported, .poweredOff, .resetting:
                return completion(.NotAvailable)
            case .unknown:
                return completion(.NotDetermined)
            }
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        bluetooth.completion = completion
        
        switch bluetooth.bluetoothManager.state {
        case .unsupported, .poweredOff, .resetting:
            print("[🚨 Arek 🚨] bluetooth not available 🚫")
            return completion(.NotAvailable)
        case .unauthorized:
            print("[🚨 Arek 🚨] bluetooth not authorized by the user ⛔️")
            return completion(.Denied)
        case .unknown:
            print("[🚨 Arek 🚨] bluetooth could not be determined 🤔")
            return completion(.NotDetermined)
        case .poweredOn:
            bluetooth.bluetoothManager?.startAdvertising(nil)
            bluetooth.bluetoothManager?.stopAdvertising()
            break
        }
    }
}
