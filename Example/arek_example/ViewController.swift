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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArekCellVMService.numberOfVMs() + 1 // the latest is Contacts to show how to get config from `Info.plist`
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArekCell", for: indexPath) as! ArekCell

        cell.viewModel = ArekCellVMService.buildVM(index: indexPath.row)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ArekCell
        
        cell.clicked = true
    }
}
