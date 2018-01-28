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
                return .numberPad
            case .SixAlphaNumeric:
                return .asciiCapable
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func _showAlertToEnterPin(message messsage: String) {
        
        let alertView = UIAlertView(title: pinTypeSelected.alertTitle, message: messsage, delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok")
        
        alertView.alertViewStyle = .secureTextInput
        alertView.textField(at: 0)?.keyboardType = pinTypeSelected.keyboardType
        alertView.textField(at: 0)?.delegate = self
        alertView.show()
    }
    
    private func _aesKeyForString(string: String) -> String{
        var newString = string
        while newString.count != 16 {
            newString = newString + "x"
        }
        
        return newString
    }
    
    private func _saveDataWithPin(pin: String) {
        
        let aes = try! AES(key: _aesKeyForString(string: pin), iv: "0123456789012345") // aes128
        let base64String = try! aes.encrypt(Array(typedText.utf8))
        
        UserDefaults.standard.set(base64String, forKey: "BruteForce")
        UserDefaults.standard.synchronize()
        
        let hash = (typedText + pin).sha256()
        UserDefaults.standard.set(hash, forKey: "BruteForceHash")
        UserDefaults.standard.synchronize()
    }
    
    private func _loadDataWithPin(pin: String) {
        if let plainText = _plainTextWithPin(pin: pin) {
            UIAlertView(title: "Success", message: "Data: \(plainText)", delegate: nil, cancelButtonTitle: "Ok").show()
        } else {
           UIAlertView(title: "Error", message: "Wrong pin", delegate: nil, cancelButtonTitle: "Ok").show()
        }
    }
    
    private func _plainTextWithPin(pin: String) -> String? {
        if let encryptedBase64: String = UserDefaults.standard.object(forKey: "BruteForce") as? String, let hashToComapre = UserDefaults.standard.object(forKey: "BruteForceHash") as? String{
            if let decrypted = try? encryptedBase64.decryptBase64ToString(cipher: AES(key: _aesKeyForString(string: pin), iv: "0123456789012345")) {
                
                if (encryptedBase64 + pin).sha256() == hashToComapre {
                    return decrypted
                }
            }
        } else {
            UIAlertView(title: "Error", message: "No data", delegate: nil, cancelButtonTitle: "Ok").show()
        }
        
        return nil
    }
    
    @IBAction func loadButtonClicked(_ sender: UIButton) {
        saveLoadState = .Load
        _showAlertToEnterPin(message: "To load data")
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        saveLoadState = .Save
        _showAlertToEnterPin(message: "To save data")
    }
}

extension BruteForceViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= pinTypeSelected.maxLenght
    }
}

extension BruteForceViewController: UIAlertViewDelegate {
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if let buttonTitle = alertView.buttonTitle(at: buttonIndex), buttonTitle == "Ok" {
            if let pin = alertView.textField(at: 0)?.text {
                switch saveLoadState {
                case .Save:
                    _saveDataWithPin(pin: pin)
                default:
                    _loadDataWithPin(pin: pin)
                }
            }
        }
    }
}
