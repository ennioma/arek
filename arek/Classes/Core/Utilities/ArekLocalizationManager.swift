//
//  ArekLocalizationManager.swift
//  Arek
//
//  Created by Ennio Masi on 11/02/2017.
//  Copyright © 2017 ennioma. All rights reserved.
//

import Foundation

struct ArekLocalizationManager {
    var initialTitle: String = ""
    var initialMessage: String = ""
    var image: String = ""
    var reEnableTitle: String = ""
    var reEnableMessage: String = ""
    
    init(permission: String) {
        self.initialTitle = NSLocalizedString("\(permission)_initial_title", comment: "")
        self.initialMessage = NSLocalizedString("\(permission)_initial_message", comment: "")
        
        self.image = "\(permission)_image"
        
        self.reEnableTitle = NSLocalizedString("\(permission)_reenable_title", comment: "")
        self.reEnableMessage = NSLocalizedString("\(permission)_reenable_message", comment: "")
    }
}
