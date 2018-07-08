//
// CIStyle.swift
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

public protocol CIStyleDelegate {
    var styles: [CIStyle] { get set }
    func applyStyle()
}

public typealias CIStyleConditionType = () -> Bool

open class CIStyle: NSObject {
    public var borderWidth: CGFloat?
    public var borderColor: UIColor?
    public var backgroundColor: UIColor?
    public var condition: CIStyleConditionType?
    
    public init(withDefaultValues useDefault: Bool = true) {
        if useDefault {
            borderWidth = 0
            borderColor = UIColor.clear
            backgroundColor = UIColor.clear
        }
    }
    
    func apply(view: UIView) {
        if let condition = condition {
            if !condition() { // if condition is not meet then don't apply the style
                return
            }
        }
        
        if let backgroundColor = backgroundColor {
            view.backgroundColor = backgroundColor
        }
        if let borderWidth = borderWidth {
            view.layer.borderWidth = borderWidth
        }
        if let borderColor = borderColor {
            view.layer.borderColor = borderColor.cgColor
        }
    }
}
