//
//  arekTests.swift
//  arekTests
//
//  Created by Ennio Masi on 07/11/2016.
//  Copyright © 2016 ennioma. All rights reserved.
//

import XCTest
@testable import arek

class ArekInitialisersTests: XCTestCase {
    var vc: DemoViewController!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCameraInitialisation() {
        let camera = ArekCamera()
        
        self.checkDefaultConfigurationStatus(permission: camera)
        self.checkStatusNotDetermined(permission: camera)
    }
    
    func testContactsInitialiszation() {
        let contact = ArekContacts()
        
        self.checkDefaultConfigurationStatus(permission: contact)
        self.checkStatusNotDetermined(permission: contact)
    }
    
    func testEventsInitialisation() {
        let event = ArekEvent()
        
        self.checkDefaultConfigurationStatus(permission: event)
        self.checkStatusNotDetermined(permission: event)
    }
    
    func testHealthInitialisation() {
        let health = ArekHealth()
        
        self.checkDefaultConfigurationStatus(permission: health)
        self.checkStatusNotDetermined(permission: health)
    }
    
    func testLocationAlwaysInitialisation() {
        let location = ArekLocationAlways()
        
        self.checkDefaultConfigurationStatus(permission: location)
        self.checkStatusNotDetermined(permission: location)
    }
    
    func testLocationInUseInitialisation() {
        let location = ArekLocationWhenInUse()
        
        self.checkDefaultConfigurationStatus(permission: location)
        self.checkStatusNotDetermined(permission: location)
    }
    
    func testMicrophoneInitialisation() {
        let microphone = ArekMicrophone()
        
        self.checkDefaultConfigurationStatus(permission: microphone)
        self.checkStatusAuthorized(permission: microphone)
    }
    
    func testPhotoInitialisation() {
        let photo = ArekPhoto()
        
        self.checkDefaultConfigurationStatus(permission: photo)
        self.checkStatusNotDetermined(permission: photo)
    }
    
    func testReminderInitialisation() {
        let reminder = ArekReminder()
        
        self.checkDefaultConfigurationStatus(permission: reminder)
        self.checkStatusNotDetermined(permission: reminder)
    }
    
    func testNotificationsInitialisation() {
        let notification = ArekNotifications()
        
        self.checkDefaultConfigurationStatus(permission: notification)
        self.checkStatusNotDetermined(permission: notification)
    }
    
    // MARK: private utilities methods
    private func checkStatusNotDetermined(permission: ArekPermissionProtocol) {
        permission.status { (status) in
            XCTAssertEqual(status, ArekPermissionStatus.NotDetermined)
        }
    }
    
    private func checkStatusAuthorized(permission: ArekPermissionProtocol) {
        permission.status { (status) in
            XCTAssertEqual(status, ArekPermissionStatus.Authorized)
        }
    }
    
    private func checkDefaultConfigurationStatus(permission: ArekBasePermission) {
        XCTAssertEqual(permission.configuration.frequency, .OnceADay)
        XCTAssertEqual(permission.configuration.presentInitialPopup, true)
        XCTAssertEqual(permission.configuration.presentReEnablePopup, true)
    }
}
