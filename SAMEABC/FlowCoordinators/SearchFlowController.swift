//
//  MainFlowController.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 30/04/2025.
//

import UIKit
final class SearchFlowController {
    private weak var navigationController: (NavigationControllerType)?
    private var searchScreenFactory: SearchScreenFactoryType?
    
    init(navigationController: NavigationControllerType) {
        self.navigationController = navigationController
    }
    
    func startFlow() {
        searchScreenFactory = SearchScreenFactory()
        let actions = SearchAction { [self] in
            self.navigateToNoFollowers()
        } followers: { [self] followers in
            self.navigateToFollowers(followers: followers)
        }

        guard let viewController = searchScreenFactory?.searchViewBuilder(searchAction: actions)
        else { return  }
        navigationController?.pushVC(viewController, animated: true)
    }
    
    private func navigateToNoFollowers() {
        let noFollowersViewController = EmptyViewController(viewModel: EmptyViewModel(actionHandler: { [weak self] action in
            switch action {
            case .close:
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


