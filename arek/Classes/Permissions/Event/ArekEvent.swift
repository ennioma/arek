//
//  ArekEvent.swift
//  Arek
//
//  Created by Ennio Masi on 30/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import EventKit

public  class ArekEvent: ArekBaseEvent {
    override public init() {
        super.init()
        super.permission = self
        
        self.initialPopupData = ArekPopupData(title: "Events service", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "Events notifications service", message: "re enable 🙏")
        self.identifier = "ArekEvent"
    }
    
    required public init(configuration: ArekConfiguration, initialPopupData: ArekPopupData?, reEnablePopupData: ArekPopupData?) {
        fatalError("init(configuration:initialPopupData:reEnablePopupData:) has not been implemented")
    }
    
    override public func status(completion: @escaping ArekPermissionResponse) {
        switch EKEventStore.authorizationStatus(for: EKEntityType.event) {
        case .notDetermined:
            return completion(.NotDetermined)
        case .denied, .restricted:
            return completion(.Denied)
        case .authorized:
            return completion(.Authorized)
        }
    }
    
    override public func askForPermission(completion: @escaping ArekPermissionResponse) {
        EKEventStore().requestAccess(to: .event) { (granted, error) in
            if granted {
                return completion(.Authorized)
            }
            
            if let _ = error {
                return completion(.NotDetermined)
            }
            
            return completion(.Denied)
        }
    }
}
