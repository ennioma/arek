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
        super.permission = self
    }
    
    required public init(configuration: ArekConfiguration, initialPopupData: ArekPopupData?, reEnablePopupData: ArekPopupData?) {
        fatalError("init(configuration:initialPopupData:reEnablePopupData:) has not been implemented")
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
    
    public func manage(completion: @escaping ArekPermissionResponse) {
        self.status { (status) in
            self.managePermission(status: status, completion: completion)
        }
    }
    
    public func askForPermission(completion: @escaping ArekPermissionResponse) {
        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
            if granted {
                return completion(.Authorized)
            } else {
                return completion(.Denied)
            }
        }
    }
}
