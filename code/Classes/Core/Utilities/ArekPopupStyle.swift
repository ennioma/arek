//
//  ArekPopupStyle.swift
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

public struct ArekPopupStyle {
    var cornerRadius: CGFloat?
    var maskBackgroundColor: UIColor?
    var maskBackgroundAlpha: CGFloat?
    var titleTextColor: UIColor?
    var titleFont: UIFont?
    var descriptionFont: UIFont?
    var descriptionLineHeight: CGFloat?
    var headerViewHeightConstraint: CGFloat?
    
    var allowButtonTitleColor: UIColor?
    var allowButtonTitleFont: UIFont?
    
    var denyButtonTitleColor: UIColor?
    var denyButtonTitleFont: UIFont?
    
    // Paddings
    var headerViewTopSpace: CGFloat?
    var descriptionLeftSpace: CGFloat?
    var descriptionRightSpace: CGFloat?
    var descriptionTopSpace: CGFloat?
    var buttonsLeftSpace: CGFloat?
    var buttonsRightSpace: CGFloat?
    var buttonsTopSpace: CGFloat?
    var buttonsBottomSpace: CGFloat?

    public init(cornerRadius: CGFloat? = nil,
                maskBackgroundColor: UIColor? = nil,
                maskBackgroundAlpha: CGFloat? = nil,
                titleTextColor: UIColor? = nil,
                titleFont: UIFont? = nil,
                descriptionFont: UIFont? = nil,
                descriptionLineHeight: CGFloat? = nil,
                headerViewHeightConstraint: CGFloat? = nil,
                allowButtonTitleColor: UIColor? = nil,
                allowButtonTitleFont: UIFont? = nil,
                denyButtonTitleColor: UIColor? = nil,
                denyButtonTitleFont: UIFont? = nil,
                headerViewTopSpace: CGFloat? = nil,
                descriptionLeftSpace: CGFloat? = nil,
                descriptionRightSpace: CGFloat? = nil,
                descriptionTopSpace: CGFloat? = nil,
                buttonsLeftSpace: CGFloat? = nil,
                buttonsRightSpace: CGFloat? = nil,
                buttonsTopSpace: CGFloat? = nil,
                buttonsBottomSpace: CGFloat? = nil) {
        
        self.cornerRadius = cornerRadius
        self.maskBackgroundColor = maskBackgroundColor
        self.maskBackgroundAlpha = maskBackgroundAlpha
        self.titleTextColor = titleTextColor
        self.titleFont = titleFont
        self.descriptionFont = descriptionFont
        self.descriptionLineHeight = descriptionLineHeight
        self.headerViewHeightConstraint = headerViewHeightConstraint
        
        self.allowButtonTitleColor = allowButtonTitleColor
        self.allowButtonTitleFont = allowButtonTitleFont
        
        self.denyButtonTitleColor = denyButtonTitleColor
        self.denyButtonTitleFont = denyButtonTitleFont
        
        self.headerViewTopSpace = headerViewTopSpace
        self.descriptionLeftSpace = descriptionLeftSpace
        self.descriptionRightSpace = descriptionRightSpace
        self.descriptionTopSpace = descriptionTopSpace
        self.buttonsLeftSpace = buttonsLeftSpace
        self.buttonsRightSpace = buttonsRightSpace
        self.buttonsTopSpace = buttonsTopSpace
        self.buttonsBottomSpace = buttonsBottomSpace

    }
}
