//
//  WireframeInterface.swift
//  iVictim
//
//  Created by Azzaro Mujic on 5/31/16
//  Copyright (c) 2016 . All rights reserved.
//

import Foundation
import UIKit

// MARK: - Wireframe interface -
protocol WireframeInterface {
    
    weak var navigationController: UINavigationController? { get set }
    weak var viewController: UIViewController? { get set }

    func instantiateAndConfigureModule() -> UIViewController
}

// MARK: - Wireframe interface default implementation -
extension WireframeInterface {

    func pushViewOnNavigationController(animated animated: Bool) {
        navigationController?.pushViewController(instantiateAndConfigureModule(), animated: animated)
    }
    
    func popViewController(animated animated: Bool) {
        navigationController?.popViewControllerAnimated(animated)
    }
    
    func presentFromViewController(viewController: UIViewController, animated: Bool) {
    	let moduleViewController = instantiateAndConfigureModule()
    	if let navigationController = navigationController {
    		assert(navigationController.viewControllers.count == 0, "You must create a new navigation controller for presentation")
    		navigationController.viewControllers = [moduleViewController]
    		viewController.presentViewController(navigationController, animated: animated, completion: nil)
    	} else {
    		viewController.presentViewController(moduleViewController, animated: animated, completion: nil)
    	}
    }
    
    func dismissViewController(animated animated: Bool) {
        if let navigationController = self.navigationController {
        	navigationController.dismissViewControllerAnimated(animated, completion: nil)
        } else {
        	viewController?.dismissViewControllerAnimated(animated, completion: nil)
        }
    }
}
