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
        switch CBPeripheralManager.authorizationStatus() {
        case .restricted, .denied:
            completion(.Denied)
            break
        case .notDetermined, .authorized:
            switch bluetooth.bluetoothManager.state {
            case .unsupported, .poweredOff, .unauthorized:
                completion(.Denied)
                break
            case .poweredOn:
                completion(.Authorized)
                break
            case .resetting, .unknown:
                completion(.NotDetermined)
                break
            }
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        switch bluetooth.bluetoothManager.state {
        case .poweredOff:
            print("[🚨 Arek 🚨] bluetooth is powered off ⛔️")
            completion(.Denied)
            break
        case .unsupported, .unauthorized, .resetting, .unknown:
            print("[🚨 Arek 🚨] bluetooth could not be determined ⛔️")
            completion(.Denied)
            break
        case .poweredOn:
            bluetooth.completion = completion
            bluetooth.bluetoothManager?.startAdvertising(nil)
            bluetooth.bluetoothManager?.stopAdvertising()
            break
        }
    }
}
