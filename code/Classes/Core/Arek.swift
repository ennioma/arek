//
//  Arek.swift
//  Arek
//
//  Copyright (c) 2016 Ennio Masi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import UIKit

import PMAlertController

public typealias ArekPermissionResponse = (ArekPermissionStatus) -> Void

public protocol ArekPermissionProtocol: class {
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
    var configuration: ArekConfiguration = ArekConfiguration(frequency: .Always, presentInitialPopup: true, presentReEnablePopup: true)
    var initialPopupData: ArekPopupData = ArekPopupData()
    var reEnablePopupData: ArekPopupData = ArekPopupData()
    
    public init(identifier: String) {
        let data = ArekLocalizationManager(permission: identifier)
        
        self.initialPopupData = ArekPopupData(title: data.initialTitle,
                                             message: data.initialMessage,
                                             image: data.image,
                                             allowButtonTitle: data.allowButtonTitle,
                                             denyButtonTitle: data.denyButtonTitle,
                                             styling: nil)
        
        self.reEnablePopupData = ArekPopupData(title: data.reEnableTitle,
                                              message:  data.reEnableMessage,
                                              image: data.image,
                                              allowButtonTitle: data.allowButtonTitle,
                                              denyButtonTitle: data.denyButtonTitle,
                                              styling: nil)
    }

    /**
     Base init shared among each permission provided by Arek
     
     - Parameters:
         - configuration: ArekConfiguration object used to define the behaviour of the pre-iOS popup and the re-enable permission popup
         - initialPopupData: title and message related to pre-iOS popup
         - reEnablePopupData: title and message related to re-enable permission popup
     */
    public init(configuration: ArekConfiguration? = nil,
                initialPopupData: ArekPopupData? = nil,
                reEnablePopupData: ArekPopupData? = nil) {
        
        self.configuration = configuration ?? self.configuration
        self.initialPopupData = initialPopupData ?? self.initialPopupData
        self.reEnablePopupData = reEnablePopupData ?? self.reEnablePopupData
    }
    
    private func manageInitialPopup(completion: @escaping ArekPermissionResponse) {
        if self.configuration.presentInitialPopup {
            self.presentInitialPopup(title: self.initialPopupData.title,
                                     message: self.initialPopupData.message,
                                     image: self.initialPopupData.image,
                                     allowButtonTitle: self.initialPopupData.allowButtonTitle,
                                     denyButtonTitle: self.initialPopupData.denyButtonTitle,
                                     styling: self.initialPopupData.styling,
                                     completion: completion)
        } else {
            (self as? ArekPermissionProtocol)?.askForPermission(completion: completion)
        }
    }
    
    private func presentInitialPopup(title: String,
                                     message: String,
                                     image: String? = nil,
                                     allowButtonTitle: String,
                                     denyButtonTitle: String,
                                     styling: ArekPopupStyle? = nil,
                                     completion: @escaping ArekPermissionResponse) {
        
        switch self.initialPopupData.type as ArekPopupType {
        case .codeido:
            self.presentInitialCodeidoPopup(title: title,
                                            message: message,
                                            image: image!,
                                            allowButtonTitle: allowButtonTitle,
                                            denyButtonTitle: denyButtonTitle,
                                            styling: styling,
                                            completion: completion)
            break
        case .native:
            self.presentInitialNativePopup(title: title,
                                           message: message,
                                           allowButtonTitle: allowButtonTitle,
                                           denyButtonTitle: denyButtonTitle,
                                           completion: completion)
            break
        }
    }
    
    private func presentInitialCodeidoPopup(title: String,
                                            message: String,
                                            image: String,
                                            allowButtonTitle: String,
                                            denyButtonTitle: String,
                                            styling: ArekPopupStyle?,
                                            completion: @escaping ArekPermissionResponse) {
        
        let alertVC = PMAlertController(title: title,
                                        description: message,
                                        image: UIImage(named: image),
                                        style: .walkthrough)
        
        let denyAction = PMAlertAction(title: denyButtonTitle, style: .cancel, action: {
            completion(.denied)
            alertVC.dismiss(animated: true, completion: nil)
        })
        
        let allowAction = PMAlertAction(title: allowButtonTitle, style: .default, action: {
            (self as? ArekPermissionProtocol)?.askForPermission(completion: completion)
            alertVC.dismiss(animated: true, completion: nil)
        })
        
        self.apply(styling, to: alertVC, with: message)
        self.apply(styling, to: denyAction, and: allowAction)
        
        alertVC.addAction(denyAction)
        alertVC.addAction(allowAction)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            DispatchQueue.main.async {
                topController.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    private func apply(_ styling: ArekPopupStyle?, to denyAction: PMAlertAction, and allowAction: PMAlertAction) {
        guard let styling = styling else {
            return
        }
        
        if let denyButtonTitleColor = styling.denyButtonTitleColor {
            denyAction.setTitleColor(denyButtonTitleColor, for: .normal)
        }
        if let denyButtonTitleFont = styling.denyButtonTitleFont {
            denyAction.titleLabel?.font = denyButtonTitleFont
        }
        if let allowButtonTitleColor = styling.allowButtonTitleColor {
            allowAction.setTitleColor(allowButtonTitleColor, for: .normal)
        }
        if let allowButtonTitleFont = styling.allowButtonTitleFont {
            allowAction.titleLabel?.font = allowButtonTitleFont
        }

    }
        
    private func apply(_ styling: ArekPopupStyle?, to alertVC: PMAlertController, with message: String) {
        guard let styling = styling else {
            return
        }
        
        if let cornerRadius = styling.cornerRadius {
            alertVC.view.layer.cornerRadius = cornerRadius
        }
        if let alertMaskBackgroundColor = styling.maskBackgroundColor {
            alertVC.alertMaskBackground.backgroundColor = alertMaskBackgroundColor
        }
        if let alertMaskBackgroundAlpha = styling.maskBackgroundAlpha {
            alertVC.alertMaskBackground.alpha = alertMaskBackgroundAlpha
        }
        if let alertTitleTextColor = styling.titleTextColor {
            alertVC.alertTitle.textColor = alertTitleTextColor
        }
        if let alertTitleFont = styling.titleFont {
            alertVC.alertTitle.font = alertTitleFont
        }
        if let alertDescriptionFont = styling.descriptionFont {
            alertVC.alertDescription.font = alertDescriptionFont
        }
        if let headerViewHeightConstraint = styling.headerViewHeightConstraint {
            alertVC.headerViewHeightConstraint.constant = headerViewHeightConstraint
        }
        if let headerViewTopSpace = styling.headerViewTopSpace {
            alertVC.headerViewTopSpaceConstraint.constant = headerViewTopSpace
        }
        if let alertDescriptionLeftSpace = styling.descriptionLeftSpace {
            alertVC.alertContentStackViewLeadingConstraint.constant = alertDescriptionLeftSpace
        }
        if let alertDescriptionRightSpace = styling.descriptionRightSpace {
            alertVC.alertContentStackViewTrailingConstraint.constant = alertDescriptionRightSpace
        }
        if let alertDescriptionTopSpace = styling.descriptionTopSpace {
            alertVC.alertContentStackViewTopConstraint.constant = alertDescriptionTopSpace
        }
        if let alertButtonsLeftSpace = styling.buttonsLeftSpace {
            alertVC.alertActionStackViewLeadingConstraint.constant = alertButtonsLeftSpace
        }
        if let alertButtonsRightSpace = styling.buttonsRightSpace {
            alertVC.alertActionStackViewTrailingConstraint.constant = alertButtonsRightSpace
        }
        if let alertButtonsTopSpace = styling.buttonsTopSpace {
            alertVC.alertActionStackViewTopConstraint.constant = alertButtonsTopSpace
        }
        if let alertButtonsBottomSpace = styling.buttonsBottomSpace {
            alertVC.alertActionStackViewBottomConstraint.constant = alertButtonsBottomSpace
        }
        
        if let alertDescriptionLineHeight = styling.descriptionLineHeight {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = alertDescriptionLineHeight
            let attrString = NSMutableAttributedString(string: message)
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
            alertVC.alertDescription.attributedText = attrString
        }
    }
    
    private func presentInitialNativePopup(title: String,
                                           message: String,
                                           allowButtonTitle: String,
                                           denyButtonTitle: String,
                                           completion: @escaping ArekPermissionResponse) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let allow = UIAlertAction(title: allowButtonTitle, style: .default) { _ in
            (self as? ArekPermissionProtocol)?.askForPermission(completion: completion)
            alert.dismiss(animated: true, completion: nil)
        }
        
        let deny = UIAlertAction(title: denyButtonTitle, style: .cancel) { _ in
            completion(.denied)
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(deny)
        alert.addAction(allow)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            DispatchQueue.main.async {
                topController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func presentReEnablePopup() {
        guard let permission = self as? ArekPermissionProtocol else { return }
        
        if self.configuration.canPresentReEnablePopup(permission: permission) {
            self.presentReEnablePopup(title: self.reEnablePopupData.title,
                                      message: self.reEnablePopupData.message,
                                      image: self.reEnablePopupData.image,
                                      allowButtonTitle: self.reEnablePopupData.allowButtonTitle,
                                      denyButtonTitle: self.reEnablePopupData.denyButtonTitle)
        } else {
            print("[🚨 Arek 🚨] for \(self) present re-enable not allowed")
        }
    }

    private func presentReEnablePopup(title: String,
                                      message: String,
                                      image: String?,
                                      allowButtonTitle: String,
                                      denyButtonTitle: String) {
        
        switch self.reEnablePopupData.type as ArekPopupType {
        case .codeido:
            self.presentReEnableCodeidoPopup(title: title,
                                             message: message,
                                             image: image!,
                                             allowButtonTitle: allowButtonTitle,
                                             denyButtonTitle: denyButtonTitle)
            break
        case .native:
            self.presentReEnableNativePopup(title: title,
                                            message: message,
                                            allowButtonTitle: allowButtonTitle,
                                            denyButtonTitle: denyButtonTitle)
            break
        }
    }
    
    private func presentReEnableNativePopup(title: String,
                                            message: String,
                                            allowButtonTitle: String,
                                            denyButtonTitle: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let allow = UIAlertAction(title: allowButtonTitle, style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
            
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
        let deny = UIAlertAction(title: denyButtonTitle, style: .cancel) { _ in
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
    
    private func presentReEnableCodeidoPopup(title: String,
                                             message: String,
                                             image: String,
                                             allowButtonTitle: String,
                                             denyButtonTitle: String) {
        
        let alertVC = PMAlertController(title: title, description: message, image: UIImage(named: image), style: .walkthrough)
        
        alertVC.addAction(PMAlertAction(title: denyButtonTitle, style: .cancel, action: {
            alertVC.dismiss(animated: true, completion: nil)
        }))
        
        alertVC.addAction(PMAlertAction(title: allowButtonTitle, style: .default, action: {
            alertVC.dismiss(animated: true, completion: nil)
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
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
        (self as? ArekPermissionProtocol)?.status { status in
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
