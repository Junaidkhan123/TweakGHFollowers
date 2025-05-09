//
//  SearchPage.swift
//  TweakGHFollowersUITests
//
//  Created by Junaid Khan on 05/05/2025.
//

import Foundation
import SBTUITestTunnelClient
import XCTest


class SearchPage: Page {
    var app: SBTUITunneledApplication
    
    private enum PageElement {
        static let textField = "UserNameTextField"
        static let searchButton = "SearchButton"
        static let view = "SearchViewController"
    }
    
    @discardableResult
    func reachedPage() -> Self {
        app.waitForExistence(elements: [userNameTextField, searchButton, view])
        return self
    }
    
    required init(app: SBTUITunneledApplication) {
        self.app = app
    }
}

extension SearchPage {
    private var userNameTextField: XCUIElement {
        return app.textField(PageElement.textField)
    }
    
    private var searchButton: XCUIElement {
        return app.button(PageElement.searchButton)
    }
    
    private var view: XCUIElement {
        return app.otherElement(PageElement.view)
    }
    
    @discardableResult
    func enterUserName(_ userName: String) -> Self {
        userNameTextField.tap()
        userNameTextField.typeText(userName)
        dismissKeyboard()
        return self
    }
    
    
    private func dismissKeyboard() {
        // Tap return/done on keyboard if it exists
        if app.keyboards.buttons["Done"].exists {
            app.keyboards.buttons["Done"].tap()
        } else if app.keyboards.buttons["Return"].exists {
            app.keyboards.buttons["Return"].tap()
        } else {
            // Tap somewhere outside the text field to dismiss keyboard
            let coordinate = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1))
            coordinate.tap()
        }
    }
    
    @discardableResult
    func tapSearchButton() -> Self {
        searchButton.firstMatch.tap()
        return self
    }
    
    @discardableResult
    func stubNetworkFollowers(withUsername username: String, returnFollowers followers: [Follower]) -> Self {
        let jsonData = try! JSONEncoder().encode(followers)
        
        let stubResponse = SBTStubResponse(
            _response: jsonData as NSObject,
            _headers: ["Content-Type": "application/json"],
            _contentType: "application/json",
            _returnCode: 200,
            _responseTime: 0,
            _activeIterations: 1
        )
        
        let _ = app.stubRequests(matching: SBTRequestMatch(url: ".*\(username)/followers.*", method: "GET"), response: stubResponse)
        
        return self
    }
}

struct Follower: Codable {
    let id: Int
    let login: String
    let avatarUrl: String
}
