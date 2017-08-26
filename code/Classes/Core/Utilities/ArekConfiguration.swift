//
//  ArekConfiguration.swift
//  Arek
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

public struct ArekConfiguration {
    var frequency: ArekPermissionFrequency = .OnceADay
    var presentInitialPopup: Bool = true
    var presentReEnablePopup: Bool = true
    
    private let week = 60.0*60.0*24.0*7.0
    private let hour = 60.0*60.0
    
    public init(frequency: ArekPermissionFrequency, presentInitialPopup: Bool, presentReEnablePopup: Bool) {
        self.frequency = frequency
        self.presentInitialPopup = presentInitialPopup
        self.presentReEnablePopup = presentReEnablePopup
    }
    
    func reEnablePopupPresented(permission: ArekPermissionProtocol) {
        UserDefaults.standard.set(Date(), forKey: permission.identifier)
        UserDefaults.standard.synchronize()
    }
    
    func canPresentReEnablePopup(permission: ArekPermissionProtocol) -> Bool {
        if !self.presentReEnablePopup {
            return false
        }
        
        switch self.frequency {
        case .OnceADay:
            guard let lastDate = self.lastDateForPermission(identifier: permission.identifier) else {
                return false
            }
            
            return !Calendar.current.isDateInToday(lastDate)
        case .EveryHour:
            guard let lastDate = self.lastDateForPermission(identifier: permission.identifier) else {
                return false
            }
            
            return Calendar.current.compare(lastDate, to: Date(), toGranularity: .hour) == ComparisonResult.orderedDescending
        case .JustOnce:
            return self.lastDateForPermission(identifier: permission.identifier) == nil
        case .OnceAWeek:
            guard let lastDate = self.lastDateForPermission(identifier: permission.identifier) else {
                return false
            }
            
            let ti = TimeInterval(week)
            let lastDateInAWeek = lastDate.addingTimeInterval(ti)
            
            return Calendar.current.compare(lastDateInAWeek, to: Date(), toGranularity: .day) == ComparisonResult.orderedDescending
        case .Always:
            return true
        }
    }
    
    private func lastDateForPermission(identifier: String) -> Date? {
        return UserDefaults.standard.object(forKey: identifier) as? Date
    }
}
