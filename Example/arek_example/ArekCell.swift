//
//  ArekCell.swift
//  arek_example
//
//  Created by Ennio Masi on 04/07/2017.
//  Copyright © 2017 ennioma. All rights reserved.
//

import Foundation
import UIKit

import arek

class ArekCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    
    
    var viewModel: ArekCellVM? {
        didSet {
            self.titleLbl.text = viewModel?.title
            
            self.viewModel?.permission.status(completion: { (status) in
                
                self.updateUI(status)
                
            })
        }
    }
    
    var clicked: Bool = false {
        didSet {
            if clicked, (viewModel?.permission != nil) {

                self.managePermission()
                
            }
        }
    }
    
    private func managePermission() {
        viewModel?.permission.manage(completion: { (status) in
            
            self.updateUI(status)
            
        })
    }
    
    private func updateUI(_ status: ArekPermissionStatus) {
        DispatchQueue.main.async {
            switch status {
            case .authorized:
                self.statusLbl.text = "✅"
            case .denied:
                self.statusLbl.text = "⛔️"
            case .notAvailable:
                self.statusLbl.text = "📵"
            case .notDetermined:
                self.statusLbl.text = "⁉️"
            }
            
            self.setSelected(false, animated: false)
        }
    }
}
