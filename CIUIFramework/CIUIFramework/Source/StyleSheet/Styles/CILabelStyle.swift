//
// CILabelStyle.swift
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

open class CILabelStyle: CIStyle {
    static var defaultFont = UIFont.systemFont(ofSize: 10)
    static var defaultTextColor = UIColor.black
    static var defaultCornerRadius: CGFloat = 0
    static var defaultTextAlignment: NSTextAlignment = .left
    
    public var font: UIFont?
    public var textColor: UIColor?
    public var cornerRadius: CGFloat?
    public var textAlignment: NSTextAlignment?
    public var range: NSRange?
    public var text: String?
    
    public override init(withDefaultValues useDefault: Bool = true) {
        if useDefault {
            font = CILabelStyle.defaultFont
            textColor = CILabelStyle.defaultTextColor
            cornerRadius = CILabelStyle.defaultCornerRadius
            textAlignment = CILabelStyle.defaultTextAlignment
        }
    }
    
    override func apply(view: UIView) {
        super.apply(view: view)
        
        if let condition = condition {
            if !condition() { // if condition is not meet then don't apply the style
                return
            }
        }
        
        if let label = view as? UILabel {
            if let range = range, let text = label.text, range.length > 0 {
                var finalAttributedText: NSMutableAttributedString?
                if let attributedText = label.attributedText {
                    finalAttributedText = NSMutableAttributedString(attributedString: attributedText)
                } else {
                    finalAttributedText = NSMutableAttributedString(string: text)
                }
                let paragraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
                if let textAlignment = textAlignment {
                    paragraphStyle.alignment = textAlignment
                }
                let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: (font ?? label.font) as Any,
                                                                NSAttributedStringKey.foregroundColor: (textColor ?? label.textColor) as Any,
                                                                NSAttributedStringKey.paragraphStyle: paragraphStyle]
                let finalRange = NSRange(location: range.location, length: range.length == NSIntegerMax ? text.count - range.location : range.length)
                finalAttributedText?.addAttributes(attributes, range: finalRange)
                label.attributedText = finalAttributedText
            } else {
                if let font = font {
                    label.font = font
                }
                if let textColor = textColor {
                    label.textColor = textColor
                }
                if let cornerRadius = cornerRadius {
                    label.layer.cornerRadius = cornerRadius
                    if cornerRadius > 0 {
                        label.layer.masksToBounds = true
                    }
                }
                if let textAlignment = textAlignment {
                    label.textAlignment = textAlignment
                }
                if let text = text {
                    label.text = text
                }
            }
        }
    }
}
