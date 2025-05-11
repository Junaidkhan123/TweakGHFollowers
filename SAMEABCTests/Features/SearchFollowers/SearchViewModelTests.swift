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
    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        sut = SearchViewModel(networkManager: mockNetworkManager,
                              searchAction: nil)
    }

    override func tearDownWithError() throws {
        mockNetworkManager = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_fetchFollowers_whenAPIReturnsEmptyArray_thenShouldInvokeNoFollowersCallback() {
        let expectation = expectation(description: "Wait for fetchFollowers to complete")
        
        let mockNetwork = MockNetworkManager()
        var isnoFollowerAction = false
        
        let actions = SearchAction {
            expectation.fulfill()
            isnoFollowerAction = true
        } followers: { _ in }
        
        let sut = SearchViewModel(networkManager: mockNetwork, searchAction: actions)
        
        sut.fetchFollowers(for: "Junaid")
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(isnoFollowerAction, "No follower action should be executed")
    }
    
    func test_fetchFollowers_whenAPIReturnsFollower_thenShouldInvokeFollowersCallback() {
        let expectation = expectation(description: "Wait for fetchFollowers to complete")
                
        var mockNetwork = MockNetworkManager()
        mockNetwork.stub = .success(Follower.stub)
        
        var expectedFollowers: [Follower]?
        
        let actions = SearchAction {} followers: {
            followers in
            expectation.fulfill()
            expectedFollowers = followers
        }
        
        let sut = SearchViewModel(networkManager: mockNetwork, searchAction: actions)
        sut.fetchFollowers(for: "Junaid")
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertNotNil(expectedFollowers, "Followers should not be Nil")
    }
}

extension Follower {
    static var stub: [Follower] =
    [
        .init(login: "Junaid", avatarUrl: "www.google.com"),
        .init(login: "User2", avatarUrl: "www.apple.com")
    ]
}
