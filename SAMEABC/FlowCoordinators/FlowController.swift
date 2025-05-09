//
//  FlowController.swift
//  TweakGHFollowers
//
//  Created by Junaid Khan on 30/04/2025.
//

import UIKit

class FlowController: NSObject {
    
    var rootNavigationController: UINavigationController?
    
    required init(navigationController: UINavigationController) {
        self.rootNavigationController = navigationController
    }
    
    func startFlow() {
        assertionFailure("this method should be overriden")
    }
    
    func pushViewController( _ viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.rootNavigationController?.pushViewController(viewController, animated: animated)
        }
    }
    
     func presentViewController(_ viewController: UIViewController,
                                    animated: Bool = true,
                                    completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.rootNavigationController?.present(viewController,
                                                   animated: animated,
                                                   completion: completion)
        }
    }
    
    func popViewController(animated: Bool = true) {
        DispatchQueue.main.async {
            self.rootNavigationController?.popViewController(animated: true)
        }
    }
}
