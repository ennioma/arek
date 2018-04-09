//
//  ArekPopupStyle.swift
//  Arek
//
//  Copyright (c) 2018 Aleksandr Pasevin
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

public struct ArekPopupStyle {
    var cornerRadius: CGFloat?
    var alertMaskBackgroundColor: UIColor?
    var alertMaskBackgroundAlpha: CGFloat?
    var alertTitleTextColor: UIColor?
    var alertTitleFont: UIFont?
    var alertDescriptionFont: UIFont?
    var headerViewHeightConstraint: CGFloat?
    
    var allowButtonTitleColor: UIColor?
    var allowButtonTitleFont: UIFont?
    
    var denyButtonTitleColor: UIColor?
    var denyButtonTitleFont: UIFont?

    public init(cornerRadius: CGFloat? = nil,
                alertMaskBackgroundColor: UIColor? = nil,
                alertMaskBackgroundAlpha: CGFloat? = nil,
                alertTitleTextColor: UIColor? = nil,
                alertTitleFont: UIFont? = nil,
                alertDescriptionFont: UIFont? = nil,
                headerViewHeightConstraint: CGFloat? = nil,
                allowButtonTitleColor: UIColor? = nil,
                allowButtonTitleFont: UIFont? = nil,
                denyButtonTitleColor: UIColor? = nil,
                denyButtonTitleFont: UIFont? = nil) {
        
        self.cornerRadius = cornerRadius
        self.alertMaskBackgroundColor = alertMaskBackgroundColor
        self.alertMaskBackgroundAlpha = alertMaskBackgroundAlpha
        self.alertTitleTextColor = alertTitleTextColor
        self.alertTitleFont = alertTitleFont
        self.alertDescriptionFont = alertDescriptionFont
        self.headerViewHeightConstraint = headerViewHeightConstraint
        
        self.allowButtonTitleColor = allowButtonTitleColor
        self.allowButtonTitleFont = allowButtonTitleFont
        
        self.denyButtonTitleColor = denyButtonTitleColor
        self.denyButtonTitleFont = denyButtonTitleFont

    }
}
