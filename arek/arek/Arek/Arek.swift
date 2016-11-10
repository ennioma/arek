//
//  Arek.swift
//  Arek
//
//  Created by Ennio Masi on 28/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import UIKit

typealias ArekPermissionResponse = (ArekPermissionStatus) -> Void

protocol ArekPermissionProtocol {
    var identifier: String { get }
    
    // MARK: Logic
    func status(completion: @escaping ArekPermissionResponse)
    func manage(completion: @escaping ArekPermissionResponse)
    func askForPermission(completion: @escaping ArekPermissionResponse)
}

class ArekBasePermission {
    var configuration: ArekConfiguration
    var initialPopupData: ArekPopupData
    var reEnablePopupData: ArekPopupData
    var permission: ArekPermissionProtocol!
    
    init() {
        self.configuration = ArekConfiguration(frequency: .OnceADay, presentInitialPopup:
            true, presentReEnablePopup: true)
        
        self.initialPopupData = ArekPopupData()
        self.reEnablePopupData = ArekPopupData()
    }
    
    required init(configuration: ArekConfiguration, initialPopupData: ArekPopupData, reEnablePopupData: ArekPopupData) {
        self.configuration = configuration
        self.initialPopupData = initialPopupData
        self.reEnablePopupData = reEnablePopupData
    }
    
    internal func manageInitialPopup(completion: @escaping ArekPermissionResponse) {
        if self.configuration.presentInitialPopup {
            self.presentInitialPopup(title: self.initialPopupData.title, message: self.initialPopupData.message, completion: completion)
        } else {
            self.permission.status(completion: completion)
        }
    }
    
    private func presentInitialPopup(title: String, message: String, completion: @escaping ArekPermissionResponse) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let allow = UIAlertAction(title: "Enable", style: .default) { (action) in
            NSLog("Navigate back to callback")
            self.permission.askForPermission(completion: completion)
            alert.dismiss(animated: true, completion: nil)
        }
        
        let deny = UIAlertAction(title: "Not now", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(deny)
        alert.addAction(allow)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    private func presentReEnablePopup() {
        if self.configuration.canPresentReEnablePopup(permission: self.permission) {
            self.presentReEnablePopup(title: self.reEnablePopupData.title, message: self.reEnablePopupData.message)
        }
    }

    private func presentReEnablePopup(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let allow = UIAlertAction(title: "Allow", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
            let url = NSURL(string: UIApplicationOpenSettingsURLString) as! URL
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        let deny = UIAlertAction(title: "Not now", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(deny)
        alert.addAction(allow)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    internal func managePermission(status: ArekPermissionStatus, completion: @escaping ArekPermissionResponse) {
        switch status {
        case .NotDetermined:
            self.manageInitialPopup(completion: completion)
            NSLog("⁉️Current Permission NotDetermined")
            break
        case .Denied:
            self.presentReEnablePopup()
            NSLog("⛔️Current Permission Denied")
            return completion(.Denied)
        case .Authorized:
            NSLog("✅Current Permission Authorized")
            return completion(.Authorized)
        }
    }
}
