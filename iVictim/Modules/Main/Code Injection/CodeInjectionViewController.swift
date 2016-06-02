//
//  CodeInjectionViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 02/06/16.
//
//

import UIKit

final class CodeInjectionViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func _loadDataIntoWebView() {
        webView.loadHTMLString(textField.text!, baseURL: nil)
        textField.resignFirstResponder()
    }
    
    @IBAction func loadTextIntoWebViewButtonClicked(sender: UIButton) {
        _loadDataIntoWebView()
    }

    @IBAction func callNumberButtonClicked(sender: UIButton) {
        textField.text = "<script>document.location='tel://1123456789'</script>"
        
    }
    @IBAction func sendMailButtonClicked(sender: UIButton) {
        textField.text = "<script>document.location='mailto://xyz@example.com? cc=prateek@damnvulnerableiosapp.com&subject=Greetings%20from%20DVIA!&body=I %20performed%20client%20injection%20successfully!'</script>"
        
    }
    @IBAction func popUpButtonClicked(sender: UIButton) {
        textField.text = "<script>alert('Hello World');</script>"
    }
    
}

extension CodeInjectionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        _loadDataIntoWebView()
        return true
    }
}