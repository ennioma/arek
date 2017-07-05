//
//  ArekCellVM.swift
//  arek_example
//
//  Created by Ennio Masi on 05/07/2017.
//  Copyright © 2017 ennioma. All rights reserved.
//

import Foundation
import arek

class ArekCellVM {
    private(set) var permission: ArekPermissionProtocol
    private(set) var title: String
    
    init(permission: ArekPermissionProtocol, title: String) {
        self.permission = permission
        self.title = title
    }
}
