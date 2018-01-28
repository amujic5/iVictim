//
//  PiracyDetectionViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 02/06/16.
//
//

import UIKit

final class PiracyDetectionViewController: UIViewController {

    var securityManager: SecurityManagerSwiftWrapper!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        securityManager = SecurityManagerSwiftWrapper()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func checkIfIsInSandboxButtonClicked(_ sender: UIButton) {
        
        let message = securityManager.isInSandbox() ? "App works in sanbox" : "App does not work in sandbox"
        UIAlertView(title: "Sandbox", message: message, delegate: nil, cancelButtonTitle: "Ok").show()
    }
    
    @IBAction func checkIfJailbrokenButtonClicked(_ sender: UIButton) {
        let message = securityManager.isJailBroken() ? "Device is jailbroken" : "Device most probably is not jail broken"
        UIAlertView(title: "Is Jailbroken?", message: message, delegate: nil, cancelButtonTitle: "Ok").show()
    }
    
    @IBAction func checkIfBeingDebugedButtonClicked(_ sender: UIButton) {
        securityManager.closeAppIfIsBeingDebugged()
    }
}
