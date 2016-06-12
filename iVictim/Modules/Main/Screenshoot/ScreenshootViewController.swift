//
//  ScreenshootViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 03/06/16.
//
//

import UIKit

final class ScreenshootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func switcherChangedValue(sender: UISwitch) {
        
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey: "hideWindow")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}


extension ScreenshootViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }
    
}