//
//  SearchViewControllerTests.swift
//  TweakGHFollowersTests
//
//  Created by Junaid Khan on 02/05/2025.
//

import XCTest
@testable import SAMEABC

final class SearchViewControllerTests: XCTestCase {
    var sut: SearchViewController!
    var viewModel: MockSearchViewModel!
    override func setUpWithError() throws {
        viewModel = MockSearchViewModel()
        sut = SearchViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
        
    }

    override func tearDownWithError() throws {
        viewModel = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_didTapSearchbutton_whenTextIsEmpty_thenFetchFollowersShouldNotBeInvoke() throws {
        try sut.getButton().sendActions(for: .touchUpInside)
        
        XCTAssertEqual(viewModel.fetchFollowersCalledFor.count, 0)
    }
    
    func test_didTapSearchButton_whenThereIsSomeText_thenFetchFollowerShouldBeInvoke() throws {
        try sut.getTextField().text = "Junaid"
        
        try sut.getButton().sendActions(for: .touchUpInside)
        try sut.getButton().sendActions(for: .touchUpInside)

        XCTAssertEqual(viewModel.fetchFollowersCalledFor.count, 2)
    }
    
    func test_searchButtonLoaded_whenIsLoadingCallbackExecuted_thenHideLoadingIndicator() throws {
        
        viewModel.isLoadingCallback?(false)

        XCTAssertEqual( try sut.getButton().isLoading, false)
    }
}

private extension SearchViewController {
    func getButton() throws -> TGFButton {
        let button = self.view.subviews.first(where: { $0 is TGFButton }) as? TGFButton
        return try XCTUnwrap(button)
    }
    
    func getTextField() throws -> TGFTextField {
        let button = self.view.subviews.first(where: { $0 is TGFTextField }) as? TGFTextField
        return try XCTUnwrap(button)
    }
}
