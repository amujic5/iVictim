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
    
}

// MARK: - Wireframe interface default implementation -
extension WireframeInterface {
}


class BaseWireframe {
    
    var navigationController: UINavigationController
    var storyboard: UIStoryboard!
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        storyboard = UIStoryboard(name: storyboardName(), bundle: nil)
    }
    
    func storyboardName() -> String {
        return String(String(self).characters.split(".")[1]).stringByReplacingOccurrencesOfString("Wireframe", withString: "")
    }
}