//
//  ArekContacts.swift
//  Arek
//
//  Created by Ennio Masi on 31/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import Contacts

open class ArekContacts: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekContacts"

    public init(configuration: ArekConfiguration? = nil) {
        let data = ArekLocalizationManager(permission: self.identifier)
        
        super.init(configuration: configuration,
                   initialPopupData: ArekPopupData(title: data.initialTitle, message: data.initialMessage, image: data.image),
                   reEnablePopupData: ArekPopupData(title: data.reEnableTitle, message:  data.reEnableMessage, image: data.image))
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        switch Contacts.CNContactStore.authorizationStatus(for: CNEntityType.contacts) {
        case .authorized:
            return completion(.authorized)
        case .denied, .restricted:
            return completion(.denied)
        case .notDetermined:
            return completion(.notDetermined)
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        Contacts.CNContactStore().requestAccess(for: CNEntityType.contacts, completionHandler:  { (granted, error) in
            if let _ = error {
                print("[🚨 Arek 🚨] 🎫 not determined 🤔 error: \(error)")
                return completion(.notDetermined)
            }

            if granted {
                print("[🚨 Arek 🚨] 🎫 permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[🚨 Arek 🚨] 🎫 denied by user ⛔️")
            return completion(.denied)
        })
    }
}
