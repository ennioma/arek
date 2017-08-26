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

open class ArekBluetooth: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekBluetooth"

    let bluetooth = ArekBluetoothDelegate()

    public init() {
        super.init(identifier: self.identifier)
    }
    
    public override init(configuration: ArekConfiguration? = nil, initialPopupData: ArekPopupData? = nil, reEnablePopupData: ArekPopupData? = nil) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
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
