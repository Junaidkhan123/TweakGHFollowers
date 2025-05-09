//
//  TweakGHFollowersTests.swift
//  TweakGHFollowersTests
//
//  Created by Junaid Khan on 10/03/2025.
//

import XCTest
@testable import SAMEABC

final class BaseTextFieldTests: XCTestCase {
    var sut: BaseTextField!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = BaseTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        sut.padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        sut.layoutIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testPadding() {
        let rect = CGRect(x: 20, y: 20, width: 260, height: 260)
        XCTAssertEqual(sut.textRect(forBounds: sut.bounds), rect)
        XCTAssertEqual(sut.placeholderRect(forBounds: sut.bounds), rect)
        XCTAssertEqual(sut.editingRect(forBounds: sut.bounds), rect)

    }
}
