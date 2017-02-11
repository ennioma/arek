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
    
    public init() {
        let data = ArekLocalizationManager(permission: self.identifier)
        
        super.init(initialPopupData: ArekPopupData(title: data.initialTitle, message: data.initialMessage, image: data.image),
                   reEnablePopupData: ArekPopupData(title: data.reEnableTitle, message:  data.reEnableMessage, image: data.image))
    }

    open func status(completion: @escaping ArekPermissionResponse) {
        if #available(iOS 10.0, *) {
            let status = SFSpeechRecognizer.authorizationStatus()
            switch status {
            case .authorized:
                return completion(.authorized)
            case .restricted, .denied:
                return completion(.denied)
            case .notDetermined:
                return completion(.notDetermined)
            }
        } else {
            return completion(.notAvailable)
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        if #available(iOS 10.0, *) {            
            SFSpeechRecognizer.requestAuthorization { status in
                switch status {
                case .authorized:
                    print("[🚨 Arek 🚨] 🗣 permission authorized by user ✅")
                    return completion(.authorized)
                case .restricted, .denied:
                    print("[🚨 Arek 🚨] 🗣 permission denied by user ⛔️")
                    return completion(.denied)
                case .notDetermined:
                    print("[🚨 Arek 🚨] 🗣 permission not determined 🤔")
                    return completion(.notDetermined)
                }
            }
        } else {
            print("[🚨 Arek 🚨] 🗣 permission only available from iOS 10 ⛔️")
            return completion(.notAvailable)
        }
    }
}
