//
//  FollowersViewControllerTests.swift
//  TweakGHFollowersTests
//
//  Created by Junaid Khan on 03/05/2025.
//

import XCTest
@testable import SAMEABC

final class FollowersViewControllerTests: XCTestCase {
    var sut: FollowerViewController!
    var viewModel: MockFollowerViewModel!
    override func setUpWithError() throws {
        viewModel = MockFollowerViewModel()
        sut = FollowerViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_tapOnCloseButton_thenDidTapOnDismissIsCalledTrue() throws {
        try sut.getCloseButton().sendActions(for: .touchUpInside)
        
        XCTAssertTrue(viewModel.didTapOnDismissIsCalled)
    }
    
    func test_whenViewLoads_thenCollectionViewCellIsNotNil() throws {
        let expectedFollowers = Follower.stub
        viewModel.followers = expectedFollowers
        
        sut = FollowerViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
        
        let collectionView = try sut.getCollectionView()
        
        XCTAssertNotNil(try XCTUnwrap(collectionView.cell(at: 0)))
        
    }
    
    func test_whenViewLoads_thenCollectionViewDisplayCorrectNumberOfItems() throws {
        let expectedFollowers = Follower.stub
        viewModel.followers = expectedFollowers
        
        sut = FollowerViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
        
        let collectionView = try sut.getCollectionView()
        XCTAssertEqual(collectionView.userNameLabel(at: 0), "Junaid")
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), expectedFollowers.count)
    }
}

private extension FollowerViewController {
    func getCloseButton() throws -> TGFButton {
        let conainerView = self.view.subviews.first(where: { $0.backgroundColor == .systemBackground })
        let button = conainerView?.subviews.first(where: { $0 is TGFButton }) as? TGFButton
        return try XCTUnwrap(button)
    }
    
    func getCollectionView() throws -> UICollectionView {
        let containerView = self.view.subviews.first(where: { $0.backgroundColor == .systemBackground })
        let collectionView = containerView?.subviews.first(where: { $0 is UICollectionView }) as? UICollectionView
        return try XCTUnwrap(collectionView)
    }
}

final class MockFollowerViewModel: FollowersViewModelProtocol {
    var followers: [Follower] = []
    
    var didTapOnDismissIsCalled = false
    
    func didTapOnDismiss() {
        didTapOnDismissIsCalled = true
    }
}

private extension UICollectionView {
    func cell(at item: Int) -> FollowerCollectionViewCell {
        return dataSource?.collectionView(self, cellForItemAt: IndexPath(item: item, section: 0)) as! FollowerCollectionViewCell
    }
    
    func userNameLabel(at item: Int) -> String? {
        cell(at: item).userNameLabel.text
    }
}
