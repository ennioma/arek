//
//  ArekCell.swift
//  arek_example
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
