//
//  IBDesignable.swift
//  DTCTest
//
//  Created by somsak on 16/6/2564 BE.
//

import UIKit

@IBDesignable class ButtonRound: UIButton {
    @IBInspectable var CornerRadius:CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = CornerRadius
        }
    }
}

@IBDesignable class placeHolderTextField: UITextField {
    @IBInspectable var placeholderColor:UIColor? = nil {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: placeholderColor!])
        }
    }
}
