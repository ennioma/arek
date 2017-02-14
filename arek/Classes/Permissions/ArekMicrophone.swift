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

        let data = ArekLocalizationManager(permission: self.identifier)
        
        super.init(initialPopupData: ArekPopupData(title: data.initialTitle, message: data.initialMessage, image: data.image),
                   reEnablePopupData: ArekPopupData(title: data.reEnableTitle, message:  data.reEnableMessage, image: data.image))
    }
    
    public override init(configuration: ArekConfiguration? = nil,  initialPopupData: ArekPopupData? = nil, reEnablePopupData: ArekPopupData? = nil) {
        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
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
