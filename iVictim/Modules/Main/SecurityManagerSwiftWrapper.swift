//
//  SecurityManagerSwiftWrapper.swift
//  iVictim
//
//  Created by Azzaro Mujic on 02/06/16.
//
//

import UIKit


final class SecurityManagerSwiftWrapper {
    
    let securityManager: SecurityManager = SecurityManager()
    
    func isInSandbox() -> Bool {
        return securityManager.isInSandbox()
    }

    func closeAppIfIsBeingDebugged() {
        securityManager.disableGDB()
    }
    
    func isJailBroken() -> Bool {
        return securityManager.isJailbroken()
    }
}