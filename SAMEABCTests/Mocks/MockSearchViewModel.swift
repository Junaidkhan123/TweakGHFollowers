//
//  SearchMockViewModel.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 03/05/2025.
//

import XCTest
@testable import SAMEABC
final class MockSearchViewModel: SearchViewModelProtocol {
    var fetchFollowersCalledFor = [String]()
    
    func fetchFollowers(for name: String) {
        fetchFollowersCalledFor.append(name)
    }
    
    var isLoadingCallback: ((Bool) -> Void)?
}
