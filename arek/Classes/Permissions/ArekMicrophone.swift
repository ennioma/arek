//
//  ArekMicrophone.swift
//  Arek
//
//  Created by Ennio Masi on 02/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import AVFoundation

public class ArekMicrophone: ArekBasePermission, ArekPermissionProtocol {
    public var identifier: String = "ArekMicrophone"
    
    override public init() {
        super.init()
        self.initialPopupData = ArekPopupData(title: "I'm 🎤", message: "enable")
        self.reEnablePopupData = ArekPopupData(title: "I'm 🎤", message: "re enable 🙏")
    }
        
    public func status(completion: @escaping ArekPermissionResponse) {
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
        
    public func askForPermission(completion: @escaping ArekPermissionResponse) {
        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
            if granted {
                print("🎤 permission authorized by user ✅")
                return completion(.Authorized)
            } else {
                print("🎤 permission denied by user ⛔️")
                return completion(.Denied)
            }
        }
    }
}
