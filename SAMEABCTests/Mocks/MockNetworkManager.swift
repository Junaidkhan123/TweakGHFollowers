//
//  MockNetworkManager.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 03/05/2025.
//

import XCTest
@testable import SAMEABC

struct MockNetworkManager: NetWorkManagerProtocol {
    var stub : Result<[Follower], NetworkError> = .success([])
    
    func getFollowers(for username: String, page: Int) async -> Result<[Follower], NetworkError> {
        return stub
    }
}
