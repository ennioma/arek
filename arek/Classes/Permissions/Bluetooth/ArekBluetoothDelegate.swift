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
        case .unsupported, .poweredOff, .unauthorized:
            print("[🚨 Arek 🚨] bluetooth permission denied by user ⛔️")
            self.completion?(.Denied)
            break
        case .poweredOn:
            print("[🚨 Arek 🚨] bluetooth permission authorized by user ✅")
            self.completion?(.Authorized)
            break
        case .resetting, .unknown:
            print("[🚨 Arek 🚨] bluetooth permission not determined 🤔")
            self.completion?(.NotDetermined)
            break
        }
    }
}
