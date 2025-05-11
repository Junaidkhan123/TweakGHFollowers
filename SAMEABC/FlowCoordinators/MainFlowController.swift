//
//  MainFlowController.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 30/04/2025.
//

import UIKit
final class MainFlowController {
    private weak var navigationController: (NavigationControllerType)?
    
    init(navigationController: NavigationControllerType) {
        self.navigationController = navigationController
    }
    
     func startFlow() {
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
        
         navigationController?.pushVC(viewContorller, animated: true)
    }
    
    private func navigateToNoFollowers() {
        let noFollowersViewController = EmptyViewController(viewModel: EmptyViewModel(actionHandler: { [weak self] action in
            switch action {
            case .dismiss:
                self?.navigationController?.dismissVC(animated: true)
            }
        }))
        noFollowersViewController.modalPresentationStyle = .overCurrentContext
        navigationController?.presentVC(noFollowersViewController, animated: false)
    }
    
    private func navigateToFollowers(followers: [Follower]) {
        let viewModel = FollowersViewModel(followers: followers) { [weak self] action in
            switch action {
            case .close:
                self?.navigationController?.dismissVC(animated: true)
            }
        }
        let followersViewController = FollowerViewController(viewModel: viewModel)
        followersViewController.modalPresentationStyle = .overCurrentContext
        navigationController?.presentVC(followersViewController, animated: false)
    }
}


