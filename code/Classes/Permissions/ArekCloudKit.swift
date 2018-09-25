//
//  ArekCloudKit.swift
//  ExampleSourceCode
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

import UIKit
import CloudKit

open class ArekCloudKit: ArekBasePermission, ArekPermissionProtocol {
    open var identifier = "ArekCloudKit"

    public init() {
        super.init(identifier: self.identifier)
    }
    
    public override init(configuration: ArekConfiguration? = nil, initialPopupData: ArekPopupData? = nil, reEnablePopupData: ArekPopupData? = nil) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        CKContainer.default().status(forApplicationPermission: CKContainer_Application_Permissions.userDiscoverability, completionHandler: { applicationPermissionStatus, error in
            
            if error != nil {
                return completion(.notDetermined)
            }
            
            switch applicationPermissionStatus {
            case .granted:
                return completion(.authorized)
            case .denied:
                return completion(.denied)
            case .couldNotComplete:
                return completion(.notDetermined)
            case .initialState:
                return completion(.notDetermined)
            }
        })

    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        CKContainer.default().accountStatus { (accountStatus, error) in
            if let error = error {
                print("[🚨 Arek 🚨] ☁️ accountStatus not determined 🤔 error: \(error)")
                return completion(.notDetermined)
            }
            
            switch accountStatus {
            case .available, .restricted:
                CKContainer.default().requestApplicationPermission(CKContainer_Application_Permissions.userDiscoverability, completionHandler: { applicationPermissionStatus, error in
                    if let error = error {
                        print("[🚨 Arek 🚨] ☁️ discoverability not determined 🤔 error: \(error)")
                        return completion(.notDetermined)
                    }

                    switch applicationPermissionStatus {
                    case .denied:
                        print("[🚨 Arek 🚨] ☁️ discoverability denied by user ⛔️")
                        return completion(.denied)
                    case .granted:
                        print("[🚨 Arek 🚨] ☁️ discoverability permission authorized by user ✅")
                        return completion(.authorized)
                    case .couldNotComplete, .initialState:
                        return completion(.notDetermined)
                    }
                })
            case .noAccount:
                print("[🚨 Arek 🚨] ☁️ account not configured ⛔️")
                return completion(.denied)
            case .couldNotDetermine:
                print("[🚨 Arek 🚨] ☁️ account not determined 🤔")
                return completion(.notDetermined)
            }
        }
    }
}
