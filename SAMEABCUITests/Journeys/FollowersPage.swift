//
//  FollowersPage.swift
//  SAMEABC
//
//  Created by Junaid Khan on 09/05/2025.
//

import SBTUITestTunnelClient
import XCTest

class FollowersPage: Page {
    var app: SBTUITunneledApplication
    
    private enum PageElement {
        static let view = "FollowerViewController"
    }
    
    @discardableResult
    func reachedPage() -> Self {
        app.waitForExistence(elements: [view])
        return self
    }
    
    required init(app: SBTUITunneledApplication) {
        self.app = app
    }
}

extension FollowersPage {
    var view: XCUIElement { app.otherElement(PageElement.view) }
}
