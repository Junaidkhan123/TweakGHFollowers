//
//  FollowerViewController.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 05/04/2025.
//

import UIKit
import SDWebImage

final class FollowerViewController: UIViewController {
    // MARK: - UI Properties
    private var collectionView: UICollectionView!
    private lazy var dataSource = makeDataSource()
    private var containerView = UIView()
    private var closeButton = TGFButton(backgroundColor: .black)
    
    // MARK: - Properties
    private var viewModel: FollowersViewModelProtocol
    
    // MARK: - Constants
    private enum Constants {
        static let containerHeight: CGFloat = 270
        static let containerCornerRadius: CGFloat = 16
        static let closeButtonHeight: CGFloat = 50
        static let edgeInset: CGFloat = 16
        static let buttonTitle = "Close"
    }
    
    private enum AccessibilityIdentifier {
        static let buttonIdentifier = "closeButtonIdentifier"
        static let view = "FollowerViewController"
    }
    
    // MARK: - Initializer
    init(viewModel: FollowersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.accessibilityIdentifier = AccessibilityIdentifier.view
        configureCollectionView()
        setupView()
        applySnapShot()
    }
}

// MARK: - Setup Views
private extension FollowerViewController {
    enum FollowerSection {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<FollowerSection, Follower>
    typealias snapShot = NSDiffableDataSourceSnapshot<FollowerSection, Follower>
    
    func setupView() {
        view.backgroundColor = .black.withAlphaComponent(0.45)
        setupContainerViewAndCollectionView()
        setupCloseButton()
    }
    
    func setupContainerViewAndCollectionView() {
        view.addSubview(containerView)
        containerView.addSubview(collectionView)
        
        containerView.backgroundColor = .systemBackground
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = Constants.containerCornerRadius
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.edgeInset)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(Constants.edgeInset)
            make.height.equalTo(Constants.containerHeight)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(Constants.edgeInset)
        }
    }
    
    func setupCloseButton() {
        containerView.addSubview(closeButton)
        closeButton.buttonTitle = Constants.buttonTitle
        
        closeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.edgeInset)
            make.top.equalTo(collectionView.snp.bottom).inset(Constants.edgeInset)
            make.height.equalTo(Constants.closeButtonHeight)
            make.bottom.equalToSuperview().inset(Constants.edgeInset)
        }
        
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }
    
    @objc
    func didTapCloseButton() {
        viewModel.didTapOnDismiss()
    }
}

// MARK: - Collection View Setup
private extension FollowerViewController {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: FollowerCollectionViewLayout.layout())
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseIdentifier)
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseIdentifier, for: indexPath) as? FollowerCollectionViewCell
            cell?.configure(with: follower)
            return cell
        }
        
        return dataSource
    }
    
    func applySnapShot() {
        var snapshot = snapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.followers)
        dataSource.apply(snapshot)
    }
}
