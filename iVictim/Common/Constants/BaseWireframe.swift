//
//  BaseWireframe.swift
//  iVictim
//
//  Created by Azzaro Mujic on 02/06/16.
//
//

import UIKit

class BaseWireframe {
    
    var navigationController: UINavigationController
    var storyboard: UIStoryboard!
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        storyboard = UIStoryboard(name: storyboardName(), bundle: nil)
    }
    
    func storyboardName() -> String {
        return (String(describing: self).split(separator: ".")[1]).replacingOccurrences(of: "Wireframe", with: "")
    }
}
