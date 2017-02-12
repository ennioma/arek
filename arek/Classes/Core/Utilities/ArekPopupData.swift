//
//  ArekPopupData.swift
//  Arek
//
//  Created by Ennio Masi on 28/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation

public enum ArekPopupType {
    case codeido
    case native
}

public struct ArekPopupData {
    var title: String!
    var message: String!
    var image: String!
    var type: ArekPopupType!

    public init(title: String = "", message: String = "", image: String = "", type: ArekPopupType = .codeido) {
        self.title = title
        self.message = message
        self.image = image
        self.type = type
    }
}
