//
//  DemoViewController.swift
//  Arek
//
//  Created by Ennio Masi on 30/10/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import UIKit
import arek

class DemoViewController: UIViewController {
    weak var permissionsTV: UITableView!
    
    let permissions: Array<ArekPermissionProtocol> = [ArekCamera(), ArekCloudKit(), ArekContacts(), ArekLocationAlways(), ArekMicrophone(), ArekNotifications(), ArekPhoto(), ArekSpeechRecognizer(), ArekReminders(), ArekMediaLibrary(), ArekEvents()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let permissionsTV = UITableView()
        permissionsTV.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        permissionsTV.dataSource = self
        permissionsTV.delegate = self
        permissionsTV.register(UITableViewCell.self, forCellReuseIdentifier: "PermissionCell")
        
        self.permissionsTV = permissionsTV
        self.view.addSubview(self.permissionsTV)
        
        self.tableLayout()
    }
}

