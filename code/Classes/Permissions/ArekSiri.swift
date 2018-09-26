//
//  ArekSiri.swift
//  arek
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
import Intents

@available(iOS 10.0, *)
open class ArekSiri: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekSiri"

    public init() {
        super.init(identifier: self.identifier)
    }

    public override init(configuration: ArekConfiguration? = nil, initialPopupData: ArekPopupData? = nil, reEnablePopupData: ArekPopupData? = nil) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

    open func status(completion: @escaping ArekPermissionResponse) {
        switch INPreferences.siriAuthorizationStatus() {
        case .authorized:
            return completion(.authorized)
        case .restricted, .denied:
            return completion(.denied)
        case .notDetermined:
            return completion(.notDetermined)
        }
    }

    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        INPreferences.requestSiriAuthorization { (status) in
            switch status {
            case .notDetermined:
                print("[🚨 Arek 🚨] 🎤 permission not determined 🤔")
                return completion(.notDetermined)
            case .restricted, .denied:
                print("[🚨 Arek 🚨] 🎤 permission denied by user ⛔️")
                return completion(.denied)
            case.authorized:
                print("[🚨 Arek 🚨] 🎤 permission authorized by user ✅")
                return completion(.authorized)
            }
        }
    }
}
