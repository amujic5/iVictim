//
//  BruteForceViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 01/06/16.
//
//

import UIKit
import CryptoSwift

class BruteForceViewController: UIViewController {

    enum PinType {
        case FourDigit
        case SixAlphaNumeric
        
        var maxLenght: Int {
            switch self {
            case .FourDigit:
                return 4
            case .SixAlphaNumeric:
                return 6
            }
        }
        
        var keyboardType: UIKeyboardType {
            switch self {
            case .FourDigit:
                return .NumberPad
            case .SixAlphaNumeric:
                return .ASCIICapable
            }
        }
        
        var alertTitle: String {
            switch self {
            case .FourDigit:
                return "Enter 4 digit pin"
            case .SixAlphaNumeric:
                return "Enter 6 alphanumeric pin"
            }
        }
    }
    
    enum SaveLoadState {
        case Save
        case Load
    }
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var saveLoadState: SaveLoadState = .Save
    
    var typedText: String {
        return textField.text ?? ""
    }
    
    var pinTypeSelected: PinType {
        return segmentedControl.selectedSegmentIndex == 0 ? .FourDigit : .SixAlphaNumeric
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: animated)
    }

    private func _showAlertToEnterPin(message messsage: String) {
        
        let alertView = UIAlertView(title: pinTypeSelected.alertTitle, message: messsage, delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok")
        
        alertView.alertViewStyle = .SecureTextInput
        alertView.textFieldAtIndex(0)?.keyboardType = pinTypeSelected.keyboardType
        alertView.textFieldAtIndex(0)?.delegate = self
        alertView.show()
    }
    
    private func _aesKeyForString(string: String) -> String{
        var newString = string
        while newString.characters.count != 16 {
            newString = newString + "x"
        }
        
        return newString
    }
    
    private func _saveDataWithPin(pin: String) {
        let base64String = try! typedText.encrypt(AES(key: _aesKeyForString(pin), iv: "0123456789012345")).toBase64()
        
        NSUserDefaults.standardUserDefaults().setObject(base64String, forKey: "BruteForce")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    private func _loadDataWithPin(pin: String) {
        if let encryptedBase64: String = NSUserDefaults.standardUserDefaults().objectForKey("BruteForce") as? String {
            if let decrypted = try? encryptedBase64.decryptBase64ToString(AES(key: _aesKeyForString(pin), iv: "0123456789012345")) {
                UIAlertView(title: "Success", message: "Data: \(decrypted)", delegate: nil, cancelButtonTitle: "Ok").show()
            } else {
                UIAlertView(title: "Error", message: "Wrong pin", delegate: nil, cancelButtonTitle: "Ok").show()
            }
        } else {
            UIAlertView(title: "Error", message: "No data", delegate: nil, cancelButtonTitle: "Ok").show()
        }
    }
    
    @IBAction func loadButtonClicked(sender: UIButton) {
        saveLoadState = .Load
        _showAlertToEnterPin(message: "To load data")
    }
    
    @IBAction func saveButtonClicked(sender: UIButton) {
        saveLoadState = .Save
        _showAlertToEnterPin(message: "To save data")
    }
}

extension BruteForceViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        return newLength <= pinTypeSelected.maxLenght
    }
}

extension BruteForceViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if let buttonTitle = alertView.buttonTitleAtIndex(buttonIndex) where buttonTitle == "Ok" {
            if let pin = alertView.textFieldAtIndex(0)?.text {
                switch saveLoadState {
                case .Save:
                    _saveDataWithPin(pin)
                default:
                    _loadDataWithPin(pin)
                }
            }
        }
    }
}