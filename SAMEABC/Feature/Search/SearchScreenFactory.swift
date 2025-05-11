//
//  SearchScreenFactory.swift
//  SAMEABC
//
//  Created by Junaid Khan on 11/05/2025.
//

import UIKit
protocol SearchScreenFactoryType {
    func searchViewBuilder(searchActionCallback: SearchActionCallbacks?) -> UIViewController
}

final class SearchScreenFactory: SearchScreenFactoryType {
    func searchViewBuilder(searchActionCallback: SearchActionCallbacks? = nil) -> UIViewController {
        let networkManager = NetworkManager()
        let viewModel = SearchViewModel(networkManager: networkManager,
                                        searchActionCallback: searchActionCallback)
        return SearchViewController(viewModel: viewModel)
    }
}
