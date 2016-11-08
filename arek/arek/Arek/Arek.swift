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
    var permission: ArekPermission! { get }
    var configuration: ArekConfiguration { get }
    var identifier: String { get }
    var initialPopupData: ArekPopupData { get }
    var reEnablePopupData: ArekPopupData { get }
    
    // MARK: Logic
    func status(completion: @escaping ArekPermissionResponse)
    func manage(completion: @escaping ArekPermissionResponse)
    func askForPermission(completion: @escaping ArekPermissionResponse)
    
    init(configuration: ArekConfiguration, initialPopupData: ArekPopupData?, reEnablePopupData: ArekPopupData?)
    
    func manageInitialPopup(completion: @escaping ArekPermissionResponse)
    func presentReEnablePopup()
}

extension ArekPermissionProtocol {
    func manage(completion: @escaping ArekPermissionResponse) {
        self.permission.manage(completion: completion)
    }
    
    func manageInitialPopup(completion: @escaping ArekPermissionResponse) {
        if self.configuration.presentInitialPopup {
            self.permission.presentInitialPopup(title: self.initialPopupData.title, message: self.initialPopupData.message, completion: completion)
        } else {
            self.askForPermission(completion: completion)
        }
    }
    
    func presentReEnablePopup() {
        if self.configuration.canPresentReEnablePopup(permission: self.permission.permission) {
            self.permission.presentReEnablePopup(title: self.reEnablePopupData.title, message: self.reEnablePopupData.message)
        }
    }
}

struct ArekPermission {
    var permission: ArekPermissionProtocol
    
    init(permission: ArekPermissionProtocol) {
        self.permission = permission
    }
    
    func manage(completion: @escaping ArekPermissionResponse) {
        permission.status { (status) in
            switch status {
            case .NotDetermined:
                self.permission.manageInitialPopup(completion: completion)
                NSLog("⁉️Current Permission NotDetermined")
                break
            case .Denied:
                self.permission.presentReEnablePopup()
                NSLog("⛔️Current Permission Denied")
                return completion(.Denied)
            case .Authorized:
                NSLog("✅Current Permission Authorized")
                return completion(.Authorized)
            }
        }
    }
    
    internal func presentInitialPopup(title: String, message: String, completion: @escaping ArekPermissionResponse) {
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
    
    internal func presentReEnablePopup(title: String, message: String) {
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
}
