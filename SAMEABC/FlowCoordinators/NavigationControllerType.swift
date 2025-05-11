//
//  NavigationControllerType.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 30/04/2025.
//

import UIKit

protocol NavigationControllerType: AnyObject {
    func pushVC(_ viewController: UIViewController, animated: Bool)
    func presentVC(_ viewController: UIViewController, animated: Bool)
    func popVC(animated: Bool)
    func dismissVC(animated: Bool)
}

extension UINavigationController: NavigationControllerType {
    func pushVC(_ viewController: UIViewController, animated: Bool = true) {
        pushViewController(viewController, animated: animated)
    }
    
    func presentVC(_ viewController: UIViewController, animated: Bool = true) {
        present(viewController, animated: animated)
    }
    
    func popVC(animated: Bool = true) {
        popViewController(animated: animated)
    }
    
    func dismissVC(animated: Bool) {
        dismiss(animated: animated)
    }
}
