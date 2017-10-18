//
//  ArekMotion.swift
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
import CoreMotion

open class ArekMotion: ArekBasePermission, ArekPermissionProtocol {
    open var identifier: String = "ArekMotion"
    
    private let userKey = "ennioma.arek.motion.requested"
    private let motionManager = CMMotionActivityManager()
    
    private var motionRequested: ArekPermissionStatus {
        get {
            if let data = UserDefaults.standard.value(forKey: userKey) as? Data,
               let value = NSKeyedUnarchiver.unarchiveObject(with: data) as? String,
               let permission = ArekPermissionStatus(rawValue: value) {
                
                return permission
            }
            
            return .notDetermined
        }
        set {
            UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: newValue.rawValue), forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    public init() {
        super.init(identifier: self.identifier)
    }
    
    public override init(configuration: ArekConfiguration? = nil, initialPopupData: ArekPopupData? = nil, reEnablePopupData: ArekPopupData? = nil) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        if CMMotionActivityManager.isActivityAvailable() == false { return completion(.notAvailable) }
        
        switch self.motionRequested {
        case .notDetermined:
            return completion(.notDetermined)
        //case .denied:
            //return completion(.denied)
        default:
            self.requestMotion(completion: completion)
        }
    }
    
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        if CMMotionActivityManager.isActivityAvailable() == false { return completion(.notAvailable) }
        
        motionManager.queryActivityStarting(from: Date(), to: Date(), to: .main) { _, error in
            if let error = error as NSError? {
                if error.code == Int(CMErrorMotionActivityNotAuthorized.rawValue) ||
                   error.code == Int(CMErrorNotAuthorized.rawValue) {
                    print("[🚨 Arek 🚨] 🏃🏻 permission denied by user ⛔️")
                    
                    self.motionRequested = .denied
                    DispatchQueue.main.async { return completion(.denied) }
                } else {
                    print("[🚨 Arek 🚨] 🏃🏻 permission not determined 🤔")
                    
                    self.motionRequested = .notDetermined
                    DispatchQueue.main.async { return completion(.notDetermined) }
                }
            } else {
                print("[🚨 Arek 🚨] 🏃🏻 permission authorized by user ✅")
             
                self.motionRequested = .authorized
                DispatchQueue.main.async { return completion(.authorized) }
            }
            self.motionManager.stopActivityUpdates()
        }
    }
    
    private func requestMotion(completion: @escaping ArekPermissionResponse) {
        self.motionManager.queryActivityStarting(from: Date(), to: Date(), to: .main) { _, error in
            self.motionManager.stopActivityUpdates()
            
            if let error = error as NSError? {
                if error.code == Int(CMErrorMotionActivityNotAuthorized.rawValue) ||
                    error.code == Int(CMErrorNotAuthorized.rawValue) {
                    
                    DispatchQueue.main.async { return completion(.denied) }
                } else {
                    DispatchQueue.main.async { return completion(.notDetermined) }
                }
            } else {
                return completion(.authorized)
            }
        }
    }
}
