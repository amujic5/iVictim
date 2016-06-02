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
    
    func presentCodeInjection() {
        let view: CodeInjectionViewController = storyboard.instantiateViewController()
        navigationController.pushViewController(view, animated: true)
    }
    
    func presentTransportLayerSecurity() {
        let view: TransportLayerSecurityViewController = storyboard.instantiateViewController()
        navigationController.pushViewController(view, animated: true)
    }
    
    func presentSSLPinning() {
        let view: SSLPinningViewController = storyboard.instantiateViewController()
        navigationController.pushViewController(view, animated: true)
    }
    
    func presentBadLogIn() {
        let view: BadLogInViewController = storyboard.instantiateViewController()
        
        navigationController.pushViewController(view, animated: true)
    }
    
    func presentLocalStorage() {
        let localStorage: LocalStorageViewController = storyboard.instantiateViewController()
        navigationController.pushViewController(localStorage, animated: true)
    }
    
    func presentBruteForce() {
        let view: BruteForceViewController = storyboard.instantiateViewController()
        navigationController.pushViewController(view, animated: true)
    }
}

extension MainWireframe: HomeViewControllerOutput {
    
}