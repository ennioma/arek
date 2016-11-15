//
//  DemoTests.swift
//  arek
//
//  Created by Ennio Masi on 15/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import XCTest
@testable import arek

class DemoTests: XCTestCase {
    
    var vc: DemoViewController!
    
    override func setUp() {
        super.setUp()
        
        self.vc = DemoViewController()
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhotoInitialPopup() {
        let p = ArekPhoto()
        
        p.manage { (status) in
            XCTAssertTrue(self.vc.presentedViewController is UIAlertController)
            
            let ac = self.vc.presentedViewController as! UIAlertController
            
            XCTAssertTrue(ac.title == "Photo service")
            XCTAssertTrue(ac.message == "enable")
            XCTAssertTrue(ac.actions.count == 2)
            XCTAssertTrue(ac.actions[0].title == "Enable")
            XCTAssertTrue(ac.actions[1].title == "Not now")
        }
    }
    
    func testPhotoNativePopup() {
        let config = ArekConfiguration(frequency: .Always, presentInitialPopup: false, presentReEnablePopup: true)
        let p = ArekPhoto(configuration: config, initialPopupData: nil, reEnablePopupData: nil)
        
        let exp = expectation(description: "show native popup")
        p.manage { (status) in
        }
        
        waitForExpectations(timeout: 20, handler: { (error) in
            if let error = error {
                print(error)
            }
        })
        
        
    }
}
