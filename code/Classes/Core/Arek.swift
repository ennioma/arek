//
//  Arek.swift
//  Arek
//
//  Created by Ennio Masi on 28/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import UIKit

import PMAlertController

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
    
    public init(identifier: String) {
        let data = ArekLocalizationManager(permission: identifier)
        
        self.initialPopupData = ArekPopupData(title: data.initialTitle,
                                             message: data.initialMessage,
                                             image: data.image,
                                             allowButtonTitle: data.allowButtonTitle,
                                             denyButtonTitle: data.denyButtonTitle)
        self.reEnablePopupData = ArekPopupData(title: data.reEnableTitle,
                                              message:  data.reEnableMessage,
                                              image: data.image,
                                              allowButtonTitle: data.allowButtonTitle,
                                              denyButtonTitle: data.denyButtonTitle)
        

    }
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
            self.presentInitialPopup(title: self.initialPopupData.title, message: self.initialPopupData.message, image: self.initialPopupData.image,allowButtonTitle: self.initialPopupData.allowButtonTitle, denyButtonTitle: self.initialPopupData.denyButtonTitle, completion: completion)
        } else {
            (self as? ArekPermissionProtocol)?.askForPermission(completion: completion)
        }
    }
    
    private func presentInitialPopup(title: String, message: String, image: String? = nil, allowButtonTitle: String, denyButtonTitle: String, completion: @escaping ArekPermissionResponse) {
        switch self.initialPopupData.type as ArekPopupType {
        case .codeido:
            self.presentInitialCodeidoPopup(title: title, message: message, image: image!, allowButtonTitle: allowButtonTitle, denyButtonTitle: denyButtonTitle, completion: completion)
            break
        case .native:
            self.presentInitialNativePopup(title: title, message: message, allowButtonTitle: allowButtonTitle, denyButtonTitle: denyButtonTitle, completion: completion)
            break
        }
    }
    
    private func presentInitialCodeidoPopup(title: String, message: String, image: String, allowButtonTitle: String, denyButtonTitle: String, completion: @escaping ArekPermissionResponse) {
        let alertVC = PMAlertController(title: title, description: message, image: UIImage(named: image), style: .walkthrough)
        
        alertVC.addAction(PMAlertAction(title: denyButtonTitle, style: .cancel, action: { () -> Void in
            completion(.denied)
            alertVC.dismiss(animated: true, completion: nil)
        }))
        
        alertVC.addAction(PMAlertAction(title: allowButtonTitle, style: .default, action: { () in
            (self as? ArekPermissionProtocol)?.askForPermission(completion: completion)
            alertVC.dismiss(animated: true, completion: nil)
        }))
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(alertVC, animated: true, completion: nil)
        }
    }
    
    private func presentInitialNativePopup(title: String, message: String, allowButtonTitle: String, denyButtonTitle: String, completion: @escaping ArekPermissionResponse) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let allow = UIAlertAction(title: allowButtonTitle, style: .default) { (action) in
            (self as? ArekPermissionProtocol)?.askForPermission(completion: completion)
            alert.dismiss(animated: true, completion: nil)
        }
        
        let deny = UIAlertAction(title: denyButtonTitle, style: .cancel) { (action) in
            completion(.denied)
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
            self.presentReEnablePopup(title: self.reEnablePopupData.title, message: self.reEnablePopupData.message, image: self.reEnablePopupData.image, allowButtonTitle: self.reEnablePopupData.allowButtonTitle, denyButtonTitle: self.reEnablePopupData.denyButtonTitle)
        } else {
            print("[🚨 Arek 🚨] for \(self) present re-enable not allowed")
        }
    }

    private func presentReEnablePopup(title: String, message: String, image: String?, allowButtonTitle: String, denyButtonTitle: String) {
        switch self.reEnablePopupData.type as ArekPopupType {
        case .codeido:
            self.presentReEnableCodeidoPopup(title: title, message: message, image: image!, allowButtonTitle: allowButtonTitle, denyButtonTitle: denyButtonTitle)
            break
        case .native:
            self.presentReEnableNativePopup(title: title, message: message, allowButtonTitle: allowButtonTitle, denyButtonTitle: denyButtonTitle)
            break
        }
    }
    
    private func presentReEnableNativePopup(title: String, message: String, allowButtonTitle: String, denyButtonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let allow = UIAlertAction(title: allowButtonTitle, style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
            let url = NSURL(string: UIApplicationOpenSettingsURLString) as! URL
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else if #available(iOS 9.0, *) {
                UIApplication.shared.openURL(url)
            }
        }
        
        let deny = UIAlertAction(title: denyButtonTitle, style: .cancel) { (action) in
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
    
    private func presentReEnableCodeidoPopup(title: String, message: String, image: String, allowButtonTitle: String, denyButtonTitle: String) {
        let alertVC = PMAlertController(title: title, description: message, image: UIImage(named: image), style: .walkthrough)
        
        alertVC.addAction(PMAlertAction(title: denyButtonTitle, style: .cancel, action: { () in
            alertVC.dismiss(animated: true, completion: nil)
        }))
        
        alertVC.addAction(PMAlertAction(title: allowButtonTitle, style: .default, action: { () -> Void in
            alertVC.dismiss(animated: true, completion: nil)
            let url = NSURL(string: UIApplicationOpenSettingsURLString) as! URL
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else if #available(iOS 9.0, *) {
                UIApplication.shared.openURL(url)
            }
        }))
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(alertVC, animated: true, completion: nil)
        }
    }
    
    open func manage(completion: @escaping ArekPermissionResponse) {
        (self as? ArekPermissionProtocol)?.status { (status) in
            self.managePermission(status: status, completion: completion)
        }
    }
    
    internal func managePermission(status: ArekPermissionStatus, completion: @escaping ArekPermissionResponse) {
        switch status {
        case .notDetermined:
            self.manageInitialPopup(completion: completion)
            break
        case .denied:
            self.presentReEnablePopup()
            return completion(.denied)
        case .authorized:
            return completion(.authorized)
        case .notAvailable:
            break
        }
    }
}
