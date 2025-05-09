//
//  FollowerCollectionViewCell.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 05/04/2025.
//

import UIKit

final class FollowerCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "FollowerCell"
    
    // MARK: - UI Components
    private let avatarImageView = UIImageView()
    let userNameLabel = TGFTitleLabel(textAlignment: .center, fontSize: 12)
    private let stackView = UIStackView()
    
    private let detailsLabel = UILabel()
    private let followButton = TGFButton(backgroundColor: .systemGreen)
    
    private var closedConstraint: NSLayoutConstraint?
    private var openConstraint: NSLayoutConstraint?
    
    // Update UI when selection changes
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with follower: Follower) {
        userNameLabel.text = follower.login
        avatarImageView.image = nil
        avatarImageView.sd_setImage(with: follower.avatarURL)
        
        detailsLabel.alpha = isSelected ? 1.0 : 0.0
        followButton.alpha = isSelected ? 1.0 : 0.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
        updateAppearance()
    }
}

private extension FollowerCollectionViewCell {
    func setupView() {
        contentView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .center
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(userNameLabel)
        userNameLabel.numberOfLines = 2

        setupAvatarImageView()
        
        detailsLabel.text = "GitHub Profile"
        detailsLabel.font = UIFont.systemFont(ofSize: 10)
        detailsLabel.textAlignment = .center
        
        followButton.buttonTitle = "Follow"
        
        stackView.addArrangedSubview(detailsLabel)
        stackView.addArrangedSubview(followButton)
        
        followButton.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.width.equalTo(80)
        }
        
        stackView.setCustomSpacing(8, after: detailsLabel)
        
        closedConstraint = userNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        closedConstraint?.priority = .defaultLow
        
        openConstraint = followButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        openConstraint?.priority = .defaultLow
        
        closedConstraint?.isActive = true
        openConstraint?.isActive = false
    }
    
    func setupAvatarImageView() {
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(50)
        }
        
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 25
        
        avatarImageView.layer.borderWidth = 4
        avatarImageView.layer.borderColor = UIColor.systemPink.cgColor
    }
    
    func updateAppearance() {
        closedConstraint?.isActive = !isSelected
        openConstraint?.isActive = isSelected
        
        UIView.animate(withDuration: 0.3) {
            self.detailsLabel.alpha = self.isSelected ? 1.0 : 0.0
            self.followButton.alpha = self.isSelected ? 1.0 : 0.0
            self.layoutIfNeeded()
        }
    }
}
