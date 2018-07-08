//
// CITextViewStyle.swift
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

open class CITextViewStyle: CIStyle {
    static var defaultFont = UIFont.systemFont(ofSize: 10)
    static var defaultTextColor = UIColor.black
    static var defaultCornerRadius: CGFloat = 0
    static var defaultTextAlignment: NSTextAlignment = .left
    static var defaultContentInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    public var font: UIFont?
    public var textColor: UIColor?
    public var cornerRadius: CGFloat?
    public var textAlignment: NSTextAlignment?
    public var range: NSRange?
    public var text: String?
    public var contentInsets: UIEdgeInsets?
    
    public override init(withDefaultValues useDefault: Bool = true) {
        if useDefault {
            font = CITextViewStyle.defaultFont
            textColor = CITextViewStyle.defaultTextColor
            cornerRadius = CITextViewStyle.defaultCornerRadius
            textAlignment = CITextViewStyle.defaultTextAlignment
            contentInsets = CITextViewStyle.defaultContentInsets
        }
    }
    
    override func apply(view: UIView) {
        super.apply(view: view)
        
        if let condition = condition {
            if !condition() { // if condition is not meet then don't apply the style
                return
            }
        }
        
        if let textView = view as? UITextView {
            if let range = range, let text = textView.text, range.length > 0 {
                var finalAttributedText: NSMutableAttributedString?
                if let attributedText = textView.attributedText {
                    finalAttributedText = NSMutableAttributedString(attributedString: attributedText)
                } else {
                    finalAttributedText = NSMutableAttributedString(string: text)
                }
                let paragraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
                if let textAlignment = textAlignment {
                    paragraphStyle.alignment = textAlignment
                }
                let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: (font ?? textView.font) as Any,
                                                                NSAttributedStringKey.foregroundColor: (textColor ?? textView.textColor) as Any,
                                                                NSAttributedStringKey.paragraphStyle: paragraphStyle]
                let finalRange = NSRange(location: range.location, length: range.length == NSIntegerMax ? text.count - range.location : range.length)
                finalAttributedText?.addAttributes(attributes, range: finalRange)
                textView.attributedText = finalAttributedText
            } else {
                if let font = font {
                    textView.font = font
                }
                if let textColor = textColor {
                    textView.textColor = textColor
                }
                if let cornerRadius = cornerRadius {
                    textView.layer.cornerRadius = cornerRadius
                    if cornerRadius > 0 {
                        textView.layer.masksToBounds = true
                    }
                }
                if let textAlignment = textAlignment {
                    textView.textAlignment = textAlignment
                }
                if let text = text {
                    textView.text = text
                }
                if let contentInsets = contentInsets {
                    textView.contentInset = contentInsets
                }
            }
        }
    }
}
