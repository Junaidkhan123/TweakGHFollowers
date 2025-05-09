//
//  SearchViewModelTests.swift
//  TweakGHFollowersTests
//
//  Created by Junaid Khan on 30/04/2025.
//

import XCTest
@testable import SAMEABC

final class SearchViewModelTests: XCTestCase {
    var sut: SearchViewModel!
    var mockNetworkManager: NetWorkManagerProtocol!
    var actions: SearchActions!
    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        sut = SearchViewModel(networkManager: mockNetworkManager, searchActionCallback: { self.actions = $0 })
    }

    override func tearDownWithError() throws {
        mockNetworkManager = nil
        sut = nil
        actions = nil
        try super.tearDownWithError()
    }
    
    func test_fetchFollowers_whenAPIReturnsEmptyArray_thenShouldInvokeNoFollowersCallback() {
        let expectation = expectation(description: "Wait for fetchFollowers to complete")
        
        var receivedAction: SearchActions?
        
        let mockNetwork = MockNetworkManager()
        let sut = SearchViewModel(networkManager: mockNetwork, searchActionCallback: { action in
            receivedAction = action
            expectation.fulfill()
        })
        
        sut.fetchFollowers(for: "Junaid")
        
        waitForExpectations(timeout: 1.0)
        
        guard let action = receivedAction, case .noFollowers = action else {
            XCTFail("No followers action should be called")
            return
        }
    }
    
    func test_fetchFollowers_whenAPIReturnsFollower_thenShouldInvokeFollowersCallback() {
        let expectation = expectation(description: "Wait for fetchFollowers to complete")
        
        var receivedAction: SearchActions?
        
        var mockNetwork = MockNetworkManager()
        mockNetwork.stub = .success(Follower.stub)
        
        let sut = SearchViewModel(networkManager: mockNetwork, searchActionCallback: { action in
            receivedAction = action
            expectation.fulfill()
        })
        
        sut.fetchFollowers(for: "Junaid")
        
        waitForExpectations(timeout: 1.0)
        
        guard let action = receivedAction, case .followers = action else {
            XCTFail("followers action should be called")
            return
        }
    }
}

extension Follower {
    static var stub: [Follower] =
    [
        .init(login: "Junaid", avatarUrl: "www.google.com"),
        .init(login: "User2", avatarUrl: "www.apple.com")
    ]
}
