//
//  SearchViewModel.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 04/04/2025.
//

import Foundation

protocol SearchViewModelProtocol {
    var searchButtonModel: TGFButton.Model { get }
    var isLoadingCallback: ((Bool) -> Void)? { get set }

    func fetchFollowers(for name: String)    
}

struct SearchAction {
    var noFollowers: (() -> Void)
    var followers: (([Follower]) -> Void)
}

final class SearchViewModel: SearchViewModelProtocol {
    var isLoadingCallback: ((Bool) -> Void)?

    private var networkManager: NetWorkManagerProtocol
    private var searchAction: SearchAction?
    
    private(set) lazy var searchButtonModel: TGFButton.Model = {
        TGFButton.Model(title: "Get Followers",
                        accessibiltyIdentifier: "SearchButton",
                        isLoading: CustomObservable(false)
        ) { [weak self] in
            self?.fetchFollowers(for: "JunaidKhan123")
        }
    }()
    
    init(networkManager: NetWorkManagerProtocol,
         searchAction: SearchAction? = nil) {
        self.networkManager = networkManager
        self.searchAction = searchAction
    }
    
    func fetchFollowers(for name: String) {
        searchButtonModel.isLoading.value = true
        Task {
            let result = await networkManager.getFollowers(for: name, page: 1)
            await handleResult(result)
        }
    }
    
    @MainActor
    func handleResult(_ result: Result<[Follower], NetworkError>) {
        searchButtonModel.isLoading.value = false
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
