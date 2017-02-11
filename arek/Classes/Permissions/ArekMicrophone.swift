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
        super.init(initialPopupData: ArekPopupData(title: "Access Microphone", message: "\(Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String) needs to access the Microphone, do you want to proceed?", image: "arek_microphone_image"),
                   reEnablePopupData: ArekPopupData(title: "Access Microphone", message: "Please re-enable the access to the Microphone"))
    }
    
    open func status(completion: @escaping ArekPermissionResponse) {
        switch AVAudioSession.sharedInstance().recordPermission() {
        case AVAudioSessionRecordPermission.denied:
            return completion(.denied)
        case AVAudioSessionRecordPermission.undetermined:
            return completion(.notDetermined)
        case AVAudioSessionRecordPermission.granted:
            return completion(.authorized)
        default:
            return completion(.notDetermined)
        }
    }
        
    open func askForPermission(completion: @escaping ArekPermissionResponse) {
        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
            if granted {
                print("[🚨 Arek 🚨] 🎤 permission authorized by user ✅")
                return completion(.authorized)
            }
            print("[🚨 Arek 🚨] 🎤 permission denied by user ⛔️")
            return completion(.denied)
        }
    }
}
