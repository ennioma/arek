//
//  ArekPopupData.swift
//  Arek
//
//  Created by Ennio Masi on 28/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation

public struct ArekPopupData {
    var title: String!
    var message: String!
    public init(title: String = "", message: String = "") {
        self.title = title
        self.message = message
    }
}
