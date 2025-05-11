//
//  FollowersViewModel.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 30/04/2025.
//

import Foundation
protocol FollowersViewModelProtocol {
    var followers: [Follower] { get }
    func didTapOnDismiss()
}

enum FollowersAction {
    case close
}

typealias FollowerActionCallbacks = ((FollowersAction) -> Void)

final class FollowersViewModel: FollowersViewModelProtocol {
    private var actionCallback: FollowerActionCallbacks?
    private(set) var followers: [Follower]
    
    init(followers: [Follower],
        actionCallback: FollowerActionCallbacks? = nil) {
        self.followers = followers
        self.actionCallback = actionCallback
    }
    
    func didTapOnDismiss() {
        actionCallback?(.close)
    }
}
