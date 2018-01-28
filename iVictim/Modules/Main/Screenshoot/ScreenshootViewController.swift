//
//  ScreenshootViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 03/06/16.
//
//

import UIKit

final class ScreenshootViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
    }

    @IBAction func switcherChangedValue(_ sender: UISwitch) {
        
        UserDefaults.standard.set(sender.isOn, forKey: "hideWindow")
        UserDefaults.standard.synchronize()
    }
}

extension ScreenshootViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
