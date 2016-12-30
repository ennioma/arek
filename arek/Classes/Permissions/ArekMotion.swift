//
//  ArekMotion.swift
//  Arek
//
//  Created by Edwin Vermeer on 30/12/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import CoreMotion

open class ArekMotion: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekMotion"
    
    private let motionManager = CMMotionActivityManager()
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "I'm 🏃🏻", message: "enable"),
                   reEnablePopupData: ArekPopupData(title: "I'm 🏃🏻", message: "re enable 🙏"))
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        if UserDefaults().bool(forKey: "ArekMotion") == false {
            completion(.NotDetermined)
            return
        }
        self.motionManager.queryActivityStarting(from: Date(), to: Date(), to: OperationQueue.main) { activities, error in
            if  error?._code ?? 0 > 0 {
                completion(.Denied)
            } else {
                completion(.Authorized)
            }
            self.motionManager.stopActivityUpdates()
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        UserDefaults().set(true, forKey: "ArekMotion")
        motionManager.queryActivityStarting(from: Date(), to: Date(), to: OperationQueue.main) { activities, error in
            if error?._code ?? 0 > 0 { //CMErrorMotionActivityNotAuthorized
                print("[🚨 Arek 🚨] 🏃🏻 permission denied by user ⛔️")
                completion(.Denied)
            } else {
                print("[🚨 Arek 🚨] 🏃🏻 permission authorized by user ✅")
                completion(.Authorized)
            }
            self.motionManager.stopActivityUpdates()
        }
    }
}
