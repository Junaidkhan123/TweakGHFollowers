//
//  TGFButton.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 11/03/2025.
//

import UIKit
import SnapKit

class TGFButton: UIButton {
    
    struct Model {
        var title: String
        var accessibiltyIdentifier: String
        var isLoading: CustomObservable<Bool>
        var action: () -> Void
    }
    
    private var spinner = UIActivityIndicatorView()
    private var actionHandler: (() -> Void)?
    
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
    
    convenience init(model: Model, backgroundColor: UIColor) {
        self.init(backgroundColor: backgroundColor)
        configure(with: model)
    }
    
    
//    public var isLoading: Bool = false {
//        didSet { updateView() }
//    }
}

private extension TGFButton {
    func commonInit() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel?.textColor = .white
        
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        setupSpinner()
    }
    
    func configure(with model: Model) {
        setTitle(model.title, for: .normal)
        accessibilityIdentifier = model.accessibiltyIdentifier
        actionHandler = model.action
        model.isLoading.subscribe { [weak self] loading in
            self?.updateView(loading: loading)
        }
    }
    
    @objc
    func didTapButton() {
        actionHandler?()
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
    
    func updateView(loading: Bool) {
        if loading {
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
