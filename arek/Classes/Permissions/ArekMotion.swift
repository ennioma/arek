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
    private lazy var motionHandlerQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "arek.MotionHandlerQueue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "Access Motion", message: "\(Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String) needs to access the Motion, do you want to proceed?", image: "arek_motion_image"),
                   reEnablePopupData: ArekPopupData(title: "Access Motion", message: "Please re-enable the access to the Motion", image: "arek_motion_image"))
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        if CMMotionActivityManager.isActivityAvailable() == false {
            return completion(.notAvailable)
        }
        
        self.motionManager.queryActivityStarting(from: Date(), to: Date(), to: motionHandlerQueue) { activities, error in
            self.motionManager.stopActivityUpdates()
            
            if let error = error as? NSError {
                if error.code == Int(CMErrorMotionActivityNotAuthorized.rawValue) ||
                    error.code == Int(CMErrorNotAuthorized.rawValue) {

                    DispatchQueue.main.async {
                        return completion(.denied)
                    }
                } else {
                    DispatchQueue.main.async {
                        return completion(.notDetermined)
                    }
                }
            } else {
                return completion(.authorized)
            }
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        if CMMotionActivityManager.isActivityAvailable() == false {
            return completion(.notAvailable)
        }
        
        motionManager.queryActivityStarting(from: Date(), to: Date(), to: motionHandlerQueue) { activities, error in
            if let error = error as? NSError {
                if error.code == Int(CMErrorMotionActivityNotAuthorized.rawValue) ||
                   error.code == Int(CMErrorNotAuthorized.rawValue) {
                    print("[🚨 Arek 🚨] 🏃🏻 permission denied by user ⛔️")
                    DispatchQueue.main.async {
                        return completion(.denied)
                    }
                } else {
                    print("[🚨 Arek 🚨] 🏃🏻 permission not determined 🤔")
                    DispatchQueue.main.async {
                        return completion(.notDetermined)
                    }
                }
            } else {
                print("[🚨 Arek 🚨] 🏃🏻 permission authorized by user ✅")
                DispatchQueue.main.async {
                    return completion(.authorized)
                }
            }
            self.motionManager.stopActivityUpdates()
        }
    }
}
