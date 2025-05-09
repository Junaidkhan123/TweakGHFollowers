//
//  SearchJourneyUITest.swift
//  TweakGHFollowersUITests
//
//  Created by Junaid Khan on 05/05/2025.
//

import XCTest

final class SearchJourneyUITest: TestCase {
    override func setUp() {
       super.setUp()
        app.launchApp()
    }
    
    override func tearDown() {
        app.terminate()
      super.tearDown()
    }
    
    func testJourney() throws {
        let followers = [Follower(id: 1, login: "Junaid", avatarUrl: "https://github.com/images/octocat.png")]
        
            SearchPage(app: app)
            .reachedPage()
            .enterUserName("Junaid")
            .tapSearchButton()
            .stubNetworkFollowers(withUsername: "Junaid", returnFollowers: followers)
        
        FollowersPage(app: app)
            .reachedPage()
        
    }
}
