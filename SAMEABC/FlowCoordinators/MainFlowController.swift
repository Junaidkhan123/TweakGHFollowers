//
//  MainFlowController.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 30/04/2025.
//

import UIKit

final class MainFlowController: FlowController {
    required init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }
    
    override func startFlow() {
        let viewModel = SearchViewModel(networkManager: NetworkManager(),
                                        searchActionCallback: { [weak self] action in
            switch action {
            case .noFollowers:
                self?.navigateToNoFollowers()
            case .followers(let followers):
                self?.navigateToFollowers(followers: followers)
            }
        })
        let viewContorller = SearchViewController(viewModel: viewModel)
        
        pushViewController(viewContorller)
    }
    
    private func navigateToNoFollowers() {
        let noFollowersViewController = EmptyViewController(viewModel: EmptyViewModel(actionHandler: { [weak self] action in
            switch action {
            case .dismiss:
                self?.rootNavigationController?.dismiss(animated: true)
            }
        }))
        noFollowersViewController.modalPresentationStyle = .overCurrentContext
        self.rootNavigationController?.present(noFollowersViewController, animated: false)
    }
    
    private func navigateToFollowers(followers: [Follower]) {
        let viewModel = FollowersViewModel(followers: followers) { [weak self] action in
            switch action {
            case .close:
                self?.rootNavigationController?.dismiss(animated: true)
            }
        }
        let followersViewController = FollowerViewController(viewModel: viewModel)
        followersViewController.modalPresentationStyle = .overCurrentContext
        self.rootNavigationController?.present(followersViewController, animated: false)
    }
}


