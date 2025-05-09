//
//  File.swift
//  SAMEABC
//
//  Created by Junaid Khan on 06/05/2025.
//


import XCTest
import SBTUITestTunnelClient

enum ConstantsUITests {
    static let uiTest = "uiTest"
}

// MARK: - XCUIApplication App Environment Setup
extension SBTUITunneledApplication {
    func launchApp() {
        launchEnvironment[ConstantsUITests.uiTest] = ConstantsUITests.uiTest
        launchTunnel()
    }
}
