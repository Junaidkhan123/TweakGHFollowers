//
//  TGFButton.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 11/03/2025.
//

import UIKit
import SnapKit

class TGFButton: UIButton {
    
   private var spinner = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        commonInit()
    }
    
    public var buttonTitle: String? {
        didSet {
            setTitle(buttonTitle, for: .normal)
        }
    }
    
    public var isLoading: Bool = false {
        didSet { updateView() }
    }
}

private extension TGFButton {
    private func commonInit() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel?.textColor = .white
        
        setupSpinner()
    }
    
    func setupSpinner() {
        spinner.hidesWhenStopped = true
        spinner.color = .white
        spinner.style = .medium
        
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func updateView() {
        if isLoading {
            spinner.startAnimating()
            titleLabel?.alpha = 0
            isEnabled = false
        } else {
            spinner.stopAnimating()
            titleLabel?.alpha = 1
            isEnabled = true
        }
    }
}
