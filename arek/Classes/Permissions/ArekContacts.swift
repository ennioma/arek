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

    override public init() {
        super.init()
        self.initialPopupData = ArekPopupData(title: "I'm 🎫", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "I'm 🎫", message: "re enable 🙏")
    }
        
    open func status(completion: @escaping ArekPermissionResponse) {
        switch Contacts.CNContactStore.authorizationStatus(for: CNEntityType.contacts) {
        case .authorized:
            return completion(.Authorized)
        case .denied, .restricted:
            return completion(.Denied)
        case .notDetermined:
            return completion(.NotDetermined)
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        Contacts.CNContactStore().requestAccess(for: CNEntityType.contacts, completionHandler:  { (_, error) in
            if let _ = error {
                print("🎫 permission not determined 🤔, error: \(error)")
                return completion(.NotDetermined)
            }
            
            switch Contacts.CNContactStore.authorizationStatus(for: CNEntityType.contacts) {
            case .authorized:
                print("🎫 permission authorized by user ✅")
                return completion(.Authorized)
            case .denied, .restricted:
                print("🎫 permission denied by user ⛔️")
                return completion(.Denied)
            case .notDetermined:
                print("🎫  permission not determined 🤔")
                return completion(.NotDetermined)
            }
        })
    }
}
