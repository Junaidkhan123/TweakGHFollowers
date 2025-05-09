//
//  TGFTextField.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 11/03/2025.
//

import UIKit
class TGFTextField: BaseTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tertiarySystemBackground
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        font = UIFont.preferredFont(forTextStyle: .title2)
        textAlignment = .center
        placeholder = "Enter a user name"
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        autocorrectionType = .no
        
        textColor = .label
        tintColor = .label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 44)
    }
}

#Preview {
    TGFTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
}
