//
//  arekTests.swift
//  arekTests
//
//  Created by Ennio Masi on 07/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import XCTest
@testable import arek

class arekTests: XCTestCase {
    var vc: DemoViewController!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCameraInitialisation() {
        let camera = ArekCamera()
        
        self.checkStatusNotDetermined(permission: camera)
    }
    
    func testContactsInitialiszation() {
        let contact = ArekContacts()
        
        self.checkStatusNotDetermined(permission: contact)
    }
    
    func testEventsInitialisation() {
        let event = ArekEvent()
        
        self.checkStatusNotDetermined(permission: event)
    }
    
    func testHealthInitialisation() {
        let health = ArekHealth()
        
        self.checkStatusNotDetermined(permission: health)
    }
    
    func testLocationAlwaysInitialisation() {
        let location = ArekLocationAlways()
        
        self.checkStatusNotDetermined(permission: location)
    }
    
    func testLocationInUseInitialisation() {
        let location = ArekLocationWhenInUse()
        
        self.checkStatusNotDetermined(permission: location)
    }
    
    func testMicrophoneInitialisation() {
        let microphone = ArekMicrophone()
        
        self.checkStatusAuthorized(permission: microphone)
    }
    
    func testPhotoInitialisation() {
        let photo = ArekPhoto()
        
        self.checkStatusNotDetermined(permission: photo)
    }
    
    func testReminderInitialisation() {
        let reminder = ArekReminder()
        
        self.checkStatusNotDetermined(permission: reminder)
    }
    
    func testNotificationsInitialisation() {
        let notification = ArekNotifications()
        
        self.checkStatusNotDetermined(permission: notification)
    }
    
    func checkStatusNotDetermined(permission: ArekPermissionProtocol) {
        permission.status { (status) in
            XCTAssertEqual(status, ArekPermissionStatus.NotDetermined)
        }
    }
    
    private func checkStatusAuthorized(permission: ArekPermissionProtocol) {
        permission.status { (status) in
            XCTAssertEqual(status, ArekPermissionStatus.Authorized)
        }
    }
}
