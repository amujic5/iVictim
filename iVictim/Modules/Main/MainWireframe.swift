//
//  MainWireframe.swift
//  iVictim
//
//  Created by Azzaro Mujic on 31/05/16.
//
//

import Foundation
import UIKit

final class MainWireframe: BaseWireframe {
    
    
    func showHomeScreen() {
        let view: HomeViewController = storyboard.instantiateViewController()
        view.output = self
        
        let _ = view.view
        
        if let menuView = view.menuViewController {
            menuView.output = self
        }
        
        
        navigationController.pushViewController(view, animated: true)
    }
}


extension MainWireframe: MenuViewControllerOutput {
    func presentBadLogIn() {
        let view: BadLogInViewController = storyboard.instantiateViewController()
        
        navigationController.pushViewController(view, animated: true)
    }
}

extension MainWireframe: HomeViewControllerOutput {
    
}