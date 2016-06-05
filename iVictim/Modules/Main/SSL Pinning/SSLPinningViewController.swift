//
//  SSLPinningViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 02/06/16.
//
//

import UIKit

final  class SSLPinningViewController: UIViewController, NSURLSessionDelegate, NSURLSessionTaskDelegate, UITextFieldDelegate {
        
        @IBOutlet weak var urlTextField: UITextField!
        @IBOutlet weak var responseTextView: UITextView!
        @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
        
        let githubCert = "github.com"
        let corruptedCert = "corrupted"
        
        var urlSession: NSURLSession!
        
        var isSimulatingCertificateCorruption = false
        
        override func viewDidLoad() {
            super.viewDidLoad()

            urlTextField.delegate = self
            
            //let pathToCert = NSBundle.mainBundle().pathForResource(githubCert, ofType: "cer")
            // print(pathToCert)
            self.configureURLSession()
            
            self.activityIndicator.hidesWhenStopped = true
        }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
        // MARK: Button actions
 
        @IBAction func nsurlSessionRequestHandler(sender: UIButton) {
            self.activityIndicator.startAnimating()
            self.urlSession?.dataTaskWithURL(NSURL(string:self.urlTextField.text!)!, completionHandler: { ( data,  response, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.activityIndicator.stopAnimating()
                })
                
                guard let data = data where error == nil else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.responseTextView.text = error!.description
                        self.responseTextView.textColor = UIColor.redColor()
                    })
                    return
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.responseTextView.text = String(data: data, encoding: NSUTF8StringEncoding)
                    self.responseTextView.textColor = UIColor.blackColor()
                })
            }).resume()
        }
        
        private func _publicKeyForCertificate(certificate: SecCertificate) -> SecKey? {
            var publicKey: SecKey?
            
            let policy = SecPolicyCreateBasicX509()
            var trust: SecTrust?
            let trustCreationStatus = SecTrustCreateWithCertificates(certificate, policy, &trust)
            
            if let trust = trust where trustCreationStatus == errSecSuccess {
                publicKey = SecTrustCopyPublicKey(trust)
            }
            
            return publicKey
        }
        
        // MARK: SSL Config
        
        func configureURLSession() {
            self.urlSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: nil)
        }
        
        // MARK: URL session delegate
        
        func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
            let serverTrust = challenge.protectionSpace.serverTrust
            let certificate = SecTrustGetCertificateAtIndex(serverTrust!, 0)
            
            // Set SSL policies for domain name check
            let policies = NSMutableArray();
            policies.addObject(SecPolicyCreateSSL(true, (challenge.protectionSpace.host)))
            SecTrustSetPolicies(serverTrust!, policies);
            
            // Evaluate server certificate
            var result: SecTrustResultType = 0
            SecTrustEvaluate(serverTrust!, &result)
            let isServerTrusted:Bool = (Int(result) == kSecTrustResultUnspecified || Int(result) == kSecTrustResultProceed)
            
            // Get local and remote cert data
            let remoteCertificateData:NSData = SecCertificateCopyData(certificate!)
            let pathToCert = NSBundle.mainBundle().pathForResource(githubCert, ofType: "cer")
            let localCertificate:NSData = NSData(contentsOfFile: pathToCert!)!
            
            if (isServerTrusted && remoteCertificateData.isEqualToData(localCertificate)) {
                let credential:NSURLCredential = NSURLCredential(forTrust: serverTrust!)
                completionHandler(.UseCredential, credential)
            } else {
                completionHandler(.CancelAuthenticationChallenge, nil)
            }
        }
        
}
