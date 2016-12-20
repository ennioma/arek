//
//  ArekSpeechRecognizer.swift
//  Arek
//
//  Created by Edwin Vermeer on 20/12/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import Speech

open class ArekSpeechRecognizer: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekSpeechRecognizer"
    
    override public init() {
        super.init()
        self.initialPopupData = ArekPopupData(title: "I'm 🗣", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "I'm 🗣", message: "re enable 🙏")
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        if #available(iOS 10.0, *) {
            let status = SFSpeechRecognizer.authorizationStatus()
            switch status {
            case .authorized:
                return completion(.Authorized)
            case .restricted, .denied:
                return completion(.Denied)
            case .notDetermined:
                return completion(.NotDetermined)
            }
        } else {
            return completion(.Denied)
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        if #available(iOS 10.0, *) {            
            SFSpeechRecognizer.requestAuthorization { status in
                switch status {
                case .authorized:
                    print("🗣 permission authorized by user ✅")
                    return completion(.Authorized)
                case .restricted, .denied:
                    print("🗣 permission denied by iOS ⛔️")
                    return completion(.Denied)
                case .notDetermined:
                    print("🗣 permission not determined 🤔")
                    return completion(.NotDetermined)
                }
            }
        } else {
            print("🗣 permission denied by iOS ⛔️")
            return completion(.Denied)
        }
    }
}
