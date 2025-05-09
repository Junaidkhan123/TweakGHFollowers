//
//  SearchViewControllerSnapShotTests.swift
//  SAMEABCTests
//
//  Created by Junaid Khan on 05/05/2025.
//

import XCTest
import iOSSnapshotTestCase
@testable import SAMEABC

final class SearchViewControllerSnapShotTests: FBSnapshotTestCase {
    var sut: SearchViewController!
    var viewModel: MockSearchViewModel!
    override func setUp()  {
         super.setUp()
        (sut, viewModel) = makeSUT()
//        self.recordMode = true
    }

    override func tearDown()  {
        super.tearDown()
        sut = nil
        viewModel = nil
    }

    func testExample() {
        FBSnapshotVerifyView(sut.view)
    }
    
    func makeSUT() -> (SearchViewController, MockSearchViewModel) {
        let viewModel = MockSearchViewModel()
        let sut = SearchViewController(viewModel: viewModel)
        return (sut, viewModel)
    }
}
