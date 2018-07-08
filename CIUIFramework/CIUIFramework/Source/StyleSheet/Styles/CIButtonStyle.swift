//
// CIButtonStyle.swift
// CIUIFramework
//
// Copyright © 2018 Code Infiniti (www.codeinfiniti.com).
// Created by Syed Arsalan Pervez on 24/06/2018.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit

open class CIButtonStyle: CIStyle {
    static var defaultSelectedBackgroundColor = UIColor.clear
    static var defaultHighlightedBackgroundColor = UIColor.clear
    static var defaultFont = UIFont.systemFont(ofSize: 10)
    static var defaultTextColor = UIColor.black
    static var defaultSelectedTextColor = UIColor.black
    static var defaultHighlightedTextColor = UIColor.black
    static var defaultCornerRadius: CGFloat = 0
    
    public var selectedBackgroundColor: UIColor?
    public var highlightedBackgroundColor: UIColor?
    public var font: UIFont?
    public var textColor: UIColor?
    public var selectedTextColor: UIColor?
    public var highlightedTextColor: UIColor?
    public var cornerRadius: CGFloat?
    
    public override init(withDefaultValues useDefault: Bool = true) {
        if useDefault {
            selectedBackgroundColor = CIButtonStyle.defaultSelectedBackgroundColor
            highlightedBackgroundColor = CIButtonStyle.defaultHighlightedBackgroundColor
            font = CIButtonStyle.defaultFont
            textColor = CIButtonStyle.defaultTextColor
            selectedTextColor = CIButtonStyle.defaultSelectedTextColor
            highlightedTextColor = CIButtonStyle.defaultHighlightedTextColor
            cornerRadius = CIButtonStyle.defaultCornerRadius
        }
    }
    
    override func apply(view: UIView) {
        super.apply(view: view)
        
        if let condition = condition {
            if !condition() { // if condition is not meet then don't apply the style
                return
            }
        }
        
        if let button = view as? UIButton {
            if let font = font {
                button.titleLabel?.font = font
            }
            if let textColor = textColor {
                button.setTitleColor(textColor, for: .normal)
            }
            if let backgroundColor = backgroundColor {
                button.backgroundColor = backgroundColor
            }
            if let cornerRadius = cornerRadius {
                button.layer.cornerRadius = cornerRadius
                if cornerRadius > 0 {
                    button.layer.masksToBounds = true
                }
            }
        }
    }
}
