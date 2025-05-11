//
//  SearchScreenFactory.swift
//  SAMEABC
//
//  Created by Junaid Khan on 11/05/2025.
//

import UIKit
protocol SearchScreenFactoryType {
    func searchViewBuilder(searchAction: SearchAction) -> UIViewController
}

final class SearchScreenFactory: SearchScreenFactoryType {
    func searchViewBuilder(searchAction: SearchAction) -> UIViewController {
        let networkManager = NetworkManager()
        let viewModel = SearchViewModel(networkManager: networkManager,
                                        searchAction: searchAction)
        return SearchViewController(viewModel: viewModel)
    }
}
