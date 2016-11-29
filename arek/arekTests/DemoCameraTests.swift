//
//  DemoTests.swift
//  arek
//
//  Created by Ennio Masi on 15/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import XCTest
@testable import arek

class DemoCameraTests: XCTestCase {
    
    var vc: DemoViewController!
    var exp: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        
        self.vc = DemoViewController()
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.vc = nil
    }
    
    
    func testPhotoInitialPopup() {
        let p = ArekPhoto()
        self.exp = expectation(description: "Wait for first popup")
        
        p.manage { (status) in
            
        }
        
        perform(#selector(DemoCameraTests.checkPopupData), with: nil, afterDelay: 1, inModes: [RunLoopMode.defaultRunLoopMode])
        
        
        waitForExpectations(timeout: 5, handler: {(error) in
            if let error = error {
                print(error)
            }
        })
    }
    
    func testPhotoNativePopup() {
        let config = ArekConfiguration(frequency: .Always, presentInitialPopup: false, presentReEnablePopup: true)
        let p = ArekPhoto(configuration: config, initialPopupData: nil, reEnablePopupData: nil)
        
        self.exp = expectation(description: "show native popup")
        p.manage { (status) in
            
        }
        
        perform(#selector(DemoCameraTests.checkNativePopupData), with: nil, afterDelay: 1, inModes: [RunLoopMode.defaultRunLoopMode])
        
        waitForExpectations(timeout: 5, handler: { (error) in
            if let error = error {
                print(error)
            }
        })
    }
    
    func testReEnablePopup() {
        
    }
    
    // MARK
    internal func checkPopupData() {
        XCTAssertTrue(self.vc.presentedViewController is UIAlertController)
        
        let ac = self.vc.presentedViewController as! UIAlertController
        
        XCTAssertTrue(ac.title == "Photo service")
        XCTAssertTrue(ac.message == "enable")
        XCTAssertTrue(ac.actions.count == 2)
        XCTAssertTrue(ac.actions[0].title == "Not now")
        XCTAssertTrue(ac.actions[1].title == "Enable")
        
        self.exp.fulfill()
    }
    
    internal func checkNativePopupData() {
        XCTAssertTrue(UIApplication.shared.keyWindow?.rootViewController?.presentedViewController is UIAlertController)
        //XCTAssertTrue(self.vc.presentedViewController is UIAlertController)
        
        let ac = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController as? UIAlertController
        
        /*XCTAssertTrue(ac.title == "\"arek\" Would Like to Access Your Photos")
        XCTAssertTrue(ac.message == "Test message to ask 🙏 to access Photo Library")
        XCTAssertTrue(ac.actions.count == 2)
        XCTAssertTrue(ac.actions[0].title == "Don't Allow")
        XCTAssertTrue(ac.actions[1].title == "OK")*/
        
        self.exp.fulfill()
    }
}
