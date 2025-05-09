//
//  EmptyViewController.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 05/04/2025.
//

import UIKit

final class EmptyViewController: UIViewController {
    // MARK: - UI Properties
    private lazy var containerView = EmptyStateView(message: "No followers found ☹️😒",
                                               buttontitle: "Dismiss") { [weak self] in
        self?.viewModel.dismissAction()
    }
    
    // MARK: - Properties
    private var viewModel: EmptyViewModelProtocol

    // MARK: - Initializers
    init(viewModel: EmptyViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - setupViews
private extension EmptyViewController {
    func setupView() {
        view.backgroundColor = .black.withAlphaComponent(0.45)
        setupContainerView()
    }
    
    func setupContainerView() {
        view.addSubview(containerView)
                
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }
}
