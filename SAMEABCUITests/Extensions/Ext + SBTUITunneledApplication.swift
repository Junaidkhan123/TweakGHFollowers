//
//  File.swift
//  SAMEABC
//
//  Created by Junaid Khan on 09/05/2025.
//

import SBTUITestTunnelClient
extension SBTUITunneledApplication {
    func label(_ element: String) -> XCUIElement {
        return staticTexts[element].firstMatch
    }
    
    func textField(_ element: String) -> XCUIElement {
        return textFields[element].firstMatch
    }
    
    func textView(_ element: String) -> XCUIElement {
        return textViews[element].firstMatch
    }
    
    func staticText(_ element: String) -> XCUIElement {
        return staticTexts[element].firstMatch
    }
    
    func button(_ element: String) -> XCUIElement {
        return buttons[element].firstMatch.firstMatch
    }
    
    func image(_ element: String) -> XCUIElement {
        return images[element].firstMatch
    }
    
    func table(_ element: String) -> XCUIElement {
        return tables[element].firstMatch
    }
    
    func collection(_ element: String) -> XCUIElement {
        return collectionViews[element].firstMatch
    }
    
    func tableCell(_ element: String) -> XCUIElement {
        return tables.cells[element].firstMatch
    }
    
    func otherElement(_ element: String) -> XCUIElement {
        return otherElements[element].firstMatch
    }
    
    func waitForExistence(elements: [XCUIElement], timeout: TimeInterval = 15) {
        let exist = NSPredicate(format: "exists == 1")
        let expectations = elements.map({ XCTNSPredicateExpectation(predicate: exist, object: $0) })
        XCTAssertEqual(XCTWaiter.wait(for: expectations, timeout: timeout), .completed)
    }
}
