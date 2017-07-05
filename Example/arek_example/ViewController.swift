//
//  ViewController.swift
//  arek_example
//
//  Created by Ennio Masi on 11/03/2017.
//  Copyright © 2017 ennioma. All rights reserved.
//

import UIKit

import arek

struct ExamplePermission {
    var permission: ArekBasePermission
    var title: String
}

class ViewController: UIViewController {

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return ArekCellVMServiceProgrammatically.numberOfVMs()
        } else if section == 1 {
            return ArekCellVMServiceLocalizable.numberOfVMs()
        }
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArekCell", for: indexPath) as! ArekCell

        if indexPath.section == 0 {
            cell.viewModel = ArekCellVMServiceProgrammatically.buildVM(index: indexPath.row)
        } else if indexPath.section == 1 {
            cell.viewModel = ArekCellVMServiceLocalizable.buildVM(index: indexPath.row)
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Permissions configured programmatically"
        } else if section == 1 {
            return "Permissions configured with Localizable"
        }
        
        return ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ArekCell
        
        cell.clicked = true
    }
}
