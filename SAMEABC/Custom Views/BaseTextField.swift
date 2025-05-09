//
//  BaseTextField.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 11/03/2025.
//

import UIKit

class BaseTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds.inset(by: padding))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
       // return super.placeholderRect(forBounds: bounds.inset(by: padding))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds.inset(by: padding))
    }
    
    var padding =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            setNeedsLayout()
        }
    }
}
