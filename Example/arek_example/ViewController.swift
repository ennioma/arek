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
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArekCell", for: indexPath) as! ArekCell

        let configuration = ArekConfiguration(frequency: .OnceADay, presentInitialPopup: true, presentReEnablePopup: true)
        let initialPopupData = ArekPopupData(title: "Media Library Access - native", message: "Please!", image: "", allowButtonTitle: "Allow👍🏻", denyButtonTitle: "No!", type: .native)
        let reenablePopupData = ArekPopupData(title: "Media Library Access - native", message: "Re-enable please!", image: "", allowButtonTitle: "Allow👍🏻", denyButtonTitle: "No!", type: .native)
        let mediaPermission = ArekMediaLibrary(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reenablePopupData)
        
        cell.title = "Media Library Access - native"
        cell.permission = mediaPermission
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ArekCell
        
        cell.clicked = true
    }
}
