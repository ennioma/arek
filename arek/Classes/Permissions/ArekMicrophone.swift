//
//  ArekMicrophone.swift
//  Arek
//
//  Created by Ennio Masi on 02/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import AVFoundation

open class ArekMicrophone: ArekBasePermission, ArekPermissionProtocol {
    public var identifier: String = "ArekMicrophone"
    
    public init() {
        super.init(initialPopupData: ArekPopupData(title: "I'm 🎤", message: "enable"),
                   reEnablePopupData: ArekPopupData(title: "I'm 🎤", message: "re enable 🙏"))
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        switch AVAudioSession.sharedInstance().recordPermission() {
        case AVAudioSessionRecordPermission.denied:
            return completion(.Denied)
        case AVAudioSessionRecordPermission.undetermined:
            return completion(.NotDetermined)
        case AVAudioSessionRecordPermission.granted:
            return completion(.Authorized)
        default:
            return completion(.NotDetermined)
        }
    }
        
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
            if granted {
                print("[🚨 Arek 🚨] 🎤 permission authorized by user ✅")
                return completion(.Authorized)
            }
            print("[🚨 Arek 🚨] 🎤 permission denied by user ⛔️")
            return completion(.Denied)
        }
    }
}
