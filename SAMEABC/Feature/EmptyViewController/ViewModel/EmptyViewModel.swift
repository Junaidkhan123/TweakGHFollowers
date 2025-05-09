//
//  EmptyViewModel.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 05/04/2025.
//


import Foundation

protocol EmptyViewModelProtocol {
    func dismissAction()
}

enum EmptyViewControllerAction {
    case dismiss
}

typealias EmptyViewControllerActionHandler = ((EmptyViewControllerAction) -> Void)

final class EmptyViewModel: EmptyViewModelProtocol {
    // MARK: - Properties
    var actionHandler: EmptyViewControllerActionHandler?
    
    init(actionHandler: EmptyViewControllerActionHandler? = nil) {
        self.actionHandler = actionHandler
    }
    
    func dismissAction() {
        self.actionHandler?(.dismiss)
    }
}
