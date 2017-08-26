//  Arek
//
//  Copyright (c) 2016 Ennio Masi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
                return completion(.denied)
            }
            break
        case .poweredOn:
            print("[🚨 Arek 🚨] bluetooth permission authorized by user ✅")
            if let completion = self.completion {
                return completion(.authorized)
            }
            break
        case .unsupported, .poweredOff, .resetting:
            print("[🚨 Arek 🚨] bluetooth not available 🚫")
            if let completion = self.completion {
                return completion(.notAvailable)
            }
            break
        case .unknown:
            print("[🚨 Arek 🚨] bluetooth could not be determined 🤔")
            if let completion = self.completion {
                return completion(.notDetermined)
            }
            break
        }
    }
}
