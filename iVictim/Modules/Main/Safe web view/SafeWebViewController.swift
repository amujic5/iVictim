//
//  SafeWebViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 05/06/16.
//
//

import UIKit
import WebKit

class SafeWebViewController: UIViewController, WKNavigationDelegate, UITextFieldDelegate {

    weak var webView: WKWebView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var webParentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = false
        preferences.javaScriptCanOpenWindowsAutomatically = false
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let url = URL(string: "https://mysite.com")!
        
        let webView = WKWebView(frame: webParentView.frame, configuration: configuration)
        webParentView.addSubview(webView)
        
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url as URL))
        
        self.webView = webView
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if !webView.hasOnlySecureContent {
            // show message that not all content on this page was loaded securely
            UIAlertView(title: "Warning", message: "not all content on this page was loaded securely", delegate: nil, cancelButtonTitle: "Ok").show()
        }
    }
    
    private func _loadDataIntoWebView() {
        webView.loadHTMLString(textField.text!, baseURL: nil)
        textField.resignFirstResponder()
    }

    @IBAction func loadContentButtonClicked(_ sender: UIButton) {
        _loadDataIntoWebView()
    }
    
    @IBAction func callNumberButtonClicked(_ sender: UIButton) {
        textField.text = "<script>document.location='tel://1123456789'</script>"
        
    }
    @IBAction func sendMailButtonClicked(_ sender: UIButton) {
        textField.text = "<script>document.location='mailto://xyz@example.com? cc=prateek@damnvulnerableiosapp.com&subject=Greetings%20from%20DVIA!&body=I %20performed%20client%20injection%20successfully!'</script>"
        
    }
    @IBAction func popUpButtonClicked(_ sender: UIButton) {
        textField.text = "<script>alert('Hello World');</script>"
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _loadDataIntoWebView()
        
        return true
    }
    
}
