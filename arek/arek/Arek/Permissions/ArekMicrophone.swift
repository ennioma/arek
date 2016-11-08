//
//  ArekMicrophone.swift
//  Arek
//
//  Created by Ennio Masi on 02/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import AVFoundation

class ArekMicrophone: ArekPermissionProtocol {
    var permission: ArekPermission!
    var configuration: ArekConfiguration
    var identifier: String = "ArekMicrophone"
    var initialPopupData: ArekPopupData = ArekPopupData(title: "I'm 🎙", message: "enable")
    var reEnablePopupData: ArekPopupData = ArekPopupData(title: "I'm 🎙", message: "re enable 🙏")
    
    init() {
        self.configuration = ArekConfiguration(frequency: .OnceADay, presentInitialPopup: false, presentReEnablePopup: true)
        self.permission = ArekPermission(permission: self)
    }
    
    required init(configuration: ArekConfiguration, initialPopupData: ArekPopupData?, reEnablePopupData: ArekPopupData?) {
        self.configuration = configuration
        self.permission = ArekPermission(permission: self)
        
        if let initialPopupData = initialPopupData {
            self.initialPopupData = initialPopupData
        }
        
        if let reEnablePopupData = reEnablePopupData {
            self.reEnablePopupData = reEnablePopupData
        }
    }
    
    func status(completion: @escaping ArekPermissionResponse) {
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
    
    func askForPermission(completion: @escaping ArekPermissionResponse) {
        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
            if granted {
                return completion(.Authorized)
            }
            
            return completion(.Denied)
        }
    }
}
