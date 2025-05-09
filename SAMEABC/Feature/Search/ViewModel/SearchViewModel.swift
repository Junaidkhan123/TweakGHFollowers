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

enum SearchActions {
    case noFollowers
    case followers(followers: [Follower])
}

typealias SearchActionCallbacks = ((SearchActions) -> Void)

final class SearchViewModel: SearchViewModelProtocol {
    var isLoadingCallback: ((Bool) -> Void)?
    private var searchActionCallback: SearchActionCallbacks?

    private var networkManager: NetWorkManagerProtocol
    
    init(networkManager: NetWorkManagerProtocol, searchActionCallback: SearchActionCallbacks? = nil) {
        self.networkManager = networkManager
        self.searchActionCallback = searchActionCallback
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
                searchActionCallback?(.noFollowers)
            } else {
                searchActionCallback?(.followers(followers: followers))
            }
        case .failure(let error):
            print("Error fetching followers: \(error)")
        }
    }
}
