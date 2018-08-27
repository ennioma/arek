//
//  ArekHealth.swift
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
import HealthKit

open class ArekHealth: ArekBasePermission, ArekPermissionProtocol {
    public struct ArekHealthConfiguration {
        public var hkObjectType: HKObjectType?
        public var hkSampleTypesToShare: Set<HKSampleType>?
        public var hkSampleTypesToRead: Set<HKObjectType>?

        public init(hkObjectType: HKObjectType? = nil, hkSampleTypesToShare: Set<HKSampleType>? = nil, hkSampleTypesToRead: Set<HKObjectType>? = nil) {
            self.hkObjectType = hkObjectType
            self.hkSampleTypesToShare = hkSampleTypesToShare
            self.hkSampleTypesToRead = hkSampleTypesToRead
        }

        func healthAvailable() -> Bool {
            return HKHealthStore.isHealthDataAvailable()
        }
    }

    public var identifier: String = "ArekHealth"

    var healthConfiguration: ArekHealthConfiguration?
    
    public init() {
        super.init(identifier: self.identifier)
    }

    public init(configuration: ArekConfiguration? = nil, initialPopupData: ArekPopupData? = nil, reEnablePopupData: ArekPopupData? = nil, arekHealthConfiguration: ArekHealthConfiguration) {

        self.healthConfiguration = arekHealthConfiguration

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

    open func status(completion: @escaping ArekPermissionResponse) {
        guard let objectType = self.healthConfiguration?.hkObjectType else {
            return completion(.notDetermined)
        }
        
        switch HKHealthStore().authorizationStatus(for: objectType) {
        case .notDetermined:
            return completion(.notDetermined)
        case .sharingDenied:
            return completion(.denied)
        case .sharingAuthorized:
            return completion(.authorized)
        }
    }
        
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        guard
            let healthConfiguration = self.healthConfiguration,
            self.healthConfiguration?.healthAvailable() == true else {
            print("[🚨 Arek 🚨] 📈 no permissions specified 🤔")
            return completion(.notDetermined)
        }

        HKHealthStore().requestAuthorization(toShare: healthConfiguration.hkSampleTypesToShare, read: healthConfiguration.hkSampleTypesToRead) { (granted, error) in
            if let error = error {
                print("[🚨 Arek 🚨] 📈 permission not determined 🤔 error: \(error)")
                return completion(.notDetermined)
            }
            
            if granted {
                print("[🚨 Arek 🚨] 📈 permission authorized by user ✅")
                return completion(.authorized)
            }
            print("[🚨 Arek 🚨] 📈 permission denied by user ⛔️")
            return completion(.denied)
        }
    }
}
