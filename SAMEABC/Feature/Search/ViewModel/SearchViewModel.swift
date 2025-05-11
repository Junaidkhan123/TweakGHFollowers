//
//  SearchViewModel.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 04/04/2025.
//

import Foundation

protocol SearchViewModelProtocol {
    func fetchFollowers(for name: String)
    
    var isLoadingCallback: ((Bool) -> Void)? { get set }
}

struct SearchAction {
    var noFollowers: (() -> Void)
    var followers: (([Follower]) -> Void)
}

final class SearchViewModel: SearchViewModelProtocol {
    var isLoadingCallback: ((Bool) -> Void)?

    private var networkManager: NetWorkManagerProtocol
    private var searchAction: SearchAction?
    
    init(networkManager: NetWorkManagerProtocol,
         searchAction: SearchAction? = nil) {
        self.networkManager = networkManager
        self.searchAction = searchAction
    }
    
    func fetchFollowers(for name: String) {
        isLoadingCallback?(true)
        Task {
            let result = await networkManager.getFollowers(for: name, page: 1)
            await handleResult(result)
        }
    }
    
    @MainActor
    func handleResult(_ result: Result<[Follower], NetworkError>) {
        isLoadingCallback?(false)
        switch result {
        case .success(let followers):
            if followers.isEmpty {
                searchAction?.noFollowers()
            } else {
                searchAction?.followers(followers)
            }
        case .failure(let error):
            print("Error fetching followers: \(error)")
        }
    }
}
