//
//  Arek.swift
//  Arek
//
//  Created by Ennio Masi on 28/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import UIKit

public typealias ArekPermissionResponse = (ArekPermissionStatus) -> Void

public protocol ArekPermissionProtocol {
    var identifier: String { get }
    /**
     This is the key method to know if a permission has been authorized or denied.
     
     Parameter completion: this closure is invoked with the current permission status (ArekPermissionStatus)
     */
    func status(completion: @escaping ArekPermissionResponse)

    /**
     This is the key method to manage the request for a permission.
     
     The behaviour is based on the ArekConfiguration set in the permission during the initialization phase.
     
     
     Parameter completion: this closure is invoked with the current permission status (ArekPermissionStatus)
     */
    func manage(completion: @escaping ArekPermissionResponse)
    func askForPermission(completion: @escaping ArekPermissionResponse)
}

/**
 ArekBasePermission is a root class and each permission inherit from it.
 
 Don't instantiate ArekBasePermission directly.
 */
open class ArekBasePermission {
    var configuration: ArekConfiguration = ArekConfiguration(frequency: .Always, presentInitialPopup:
        true, presentReEnablePopup: true)
    var initialPopupData: ArekPopupData = ArekPopupData()
    var reEnablePopupData: ArekPopupData = ArekPopupData()
    
    /**
     Base init shared among each permission provided by Arek
     
     - Parameters:
         - configuration: ArekConfiguration object used to define the behaviour of the pre-iOS popup and the re-enable permission popup
         - initialPopupData: title and message related to pre-iOS popup
         - reEnablePopupData: title and message related to re-enable permission popup
     */
    public init(configuration: ArekConfiguration? = nil, initialPopupData: ArekPopupData? = nil, reEnablePopupData: ArekPopupData? = nil) {
        self.configuration = configuration ?? self.configuration
        self.initialPopupData = initialPopupData ?? self.initialPopupData
        self.reEnablePopupData = reEnablePopupData ?? self.reEnablePopupData
    }
    
    private func manageInitialPopup(completion: @escaping ArekPermissionResponse) {
        if self.configuration.presentInitialPopup {
            self.presentInitialPopup(title: self.initialPopupData.title, message: self.initialPopupData.message, completion: completion)
        } else {
            (self as? ArekPermissionProtocol)?.askForPermission(completion: completion)
        }
    }
    
    private func presentInitialPopup(title: String, message: String, completion: @escaping ArekPermissionResponse) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let allow = UIAlertAction(title: "Enable", style: .default) { (action) in
            (self as? ArekPermissionProtocol)?.askForPermission(completion: completion)
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
        if self is ArekPermissionProtocol && self.configuration.canPresentReEnablePopup(permission: (self as! ArekPermissionProtocol)) {
            self.presentReEnablePopup(title: self.reEnablePopupData.title, message: self.reEnablePopupData.message)
        } else {
            print("[🚨 Arek 🚨] for \(self) present re-enable not allowed")
        }
    }

    private func presentReEnablePopup(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let allow = UIAlertAction(title: "Allow", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
            let url = NSURL(string: UIApplicationOpenSettingsURLString) as! URL
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else if #available(iOS 9.0, *) {
                UIApplication.shared.openURL(url)
            }
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
    
    open func manage(completion: @escaping ArekPermissionResponse) {
        (self as? ArekPermissionProtocol)?.status { (status) in
            self.managePermission(status: status, completion: completion)
        }
    }
    
    internal func managePermission(status: ArekPermissionStatus, completion: @escaping ArekPermissionResponse) {
        switch status {
        case .NotDetermined:
            self.manageInitialPopup(completion: completion)
            break
        case .Denied:
            self.presentReEnablePopup()
            return completion(.Denied)
        case .Authorized:
            return completion(.Authorized)
        case .NotAvailable:
            break
        }
    }
}
