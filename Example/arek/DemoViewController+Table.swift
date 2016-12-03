//
//  DemoViewController+Table.swift
//  arek
//
//  Created by Ennio Masi on 07/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import Foundation
import UIKit

extension DemoViewController: UITableViewDataSource, UITableViewDelegate {
    private var cellId: String {
        get {
            return "PermissionCellID"
        }
    }
    
    func setupTable() -> UITableView {
        let permissionsTV = UITableView()
        permissionsTV.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        permissionsTV.dataSource = self
        permissionsTV.delegate = self
        permissionsTV.register(UITableViewCell.self, forCellReuseIdentifier: "PermissionCell")
        
        return permissionsTV
    }
    
    func tableLayout() {
        self.permissionsTV.frame = self.view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.permissions.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let permission = self.permissions[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            ?? UITableViewCell(style: .default, reuseIdentifier: cellId)

        cell.textLabel?.textAlignment = .center
        
        var symbol = ""
        permission.status { (status) in
            switch status {
            case .Authorized:
                symbol = "✅"
            case .Denied:
                symbol = "⛔️"
            case .NotDetermined:
                symbol = "🤔"
            }
            
            DispatchQueue.main.async {
                cell.textLabel?.text = "\(symbol) \(permission.identifier) \(symbol)"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let permission = self.permissions[indexPath.row]
        
        var symbol = ""

        permission.manage { (status) in
            switch status {
            case .Authorized:
                symbol = "✅"
            case .Denied:
                symbol = "⛔️"
            case .NotDetermined:
                symbol = "🤔"
            }
            
            print("\(symbol) \(permission.identifier) \(symbol)")
            
            DispatchQueue.main.async {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.permissionsTV.bounds.size.width, height: 80))
        headerView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        return headerView
    }
}
