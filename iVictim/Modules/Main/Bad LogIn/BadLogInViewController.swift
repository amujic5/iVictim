//
//  BadLogInViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 31/05/16.
//
//

import UIKit


class BadLogInViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func isValid() -> Bool {
        if let username =  usernameTextField.text, password = passwordTextField.text {
            return username == "admin" && password == "1234"
        }
        
        return false
    }
    
    @IBAction func logInButtonClicked(sender: AnyObject) {
        if isValid() {
            performSegueWithIdentifier("admin", sender: self)
        } else {
            let alertView = UIAlertView(title: "Error", message: "Wrong username and/or password", delegate: nil, cancelButtonTitle: "Ok")
            alertView.show()
        }
    }
}
