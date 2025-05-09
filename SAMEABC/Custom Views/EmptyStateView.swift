//
//  EmptyStateView.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 05/04/2025.
//

import UIKit

class EmptyStateView: UIView {
    private let titleLabel = TGFTitleLabel(textAlignment: .center, fontSize: 20)
    private var dismissButton = TGFButton(backgroundColor: .systemPink)
    
    private let stackView = UIStackView()
    
    private var dismissAction: (() -> Void)?
    private var message: String
    private var buttonTitle: String
    
    override init(frame: CGRect) {
        self.message = "No followers"
        self.buttonTitle = "Get Followers"
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String, buttontitle: String, buttonAction: (() -> Void)?) {
        self.message = message
        self.buttonTitle = buttontitle
        self.dismissAction = buttonAction
        super.init(frame: .zero)
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = 16
        backgroundColor = .systemBackground
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        
        setupStackView()
        setupTitleLabel()
        setupDismissButton()
    }
    
    func setupStackView() {
        addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dismissButton)
        
        dismissButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
    
    func setupTitleLabel() {
        titleLabel.text = message

    }
    
    func setupDismissButton() {
        dismissButton.setTitle(buttonTitle, for: .normal)
        dismissButton.addTarget(self, action: #selector(didTapDismissButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapDismissButton() {
        dismissAction?()
    }
}
