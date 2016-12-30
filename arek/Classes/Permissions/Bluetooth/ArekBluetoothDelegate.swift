//  Arek
//
//  Created by Edwin Vermeer on 29/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import CoreBluetooth

open class ArekBluetoothDelegate: NSObject, CBPeripheralManagerDelegate {

    open var identifier: String = "ArekBluetooth"
    
    internal var bluetoothManager: CBPeripheralManager!
    internal var completion: ArekPermissionResponse?
    
    public override init() {
        super.init()
        self.bluetoothManager = CBPeripheralManager(
            delegate: self,
            queue: nil,
            options: [CBPeripheralManagerOptionShowPowerAlertKey: false]
        )
    }
    
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {

        switch peripheral.state {
        case .unauthorized:
            print("[🚨 Arek 🚨] bluetooth permission denied by user ⛔️")
            if let completion = self.completion {
                return completion(.Denied)
            }
            break
        case .poweredOn:
            print("[🚨 Arek 🚨] bluetooth permission authorized by user ✅")
            if let completion = self.completion {
                return completion(.Authorized)
            }
            break
        case .unsupported, .poweredOff, .resetting:
            print("[🚨 Arek 🚨] bluetooth not available 🚫")
            if let completion = self.completion {
                return completion(.NotAvailable)
            }
            break
        case .unknown:
            print("[🚨 Arek 🚨] bluetooth could not be determined 🤔")
            if let completion = self.completion {
                return completion(.NotDetermined)
            }
            break
        }
    }
}
