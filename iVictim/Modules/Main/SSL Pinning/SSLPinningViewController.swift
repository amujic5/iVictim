//
//  SSLPinningViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 02/06/16.
//
//

import UIKit

final  class SSLPinningViewController: UIViewController, URLSessionDelegate, URLSessionTaskDelegate, UITextFieldDelegate {
        
        @IBOutlet weak var urlTextField: UITextField!
        @IBOutlet weak var responseTextView: UITextView!
        @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
        
        let githubCert = "github.com"
        let corruptedCert = "corrupted"
        
    var urlSession: URLSession!
        
        var isSimulatingCertificateCorruption = false
        
        override func viewDidLoad() {
            super.viewDidLoad()

            urlTextField.delegate = self
            
            //let pathToCert = NSBundle.mainBundle().pathForResource(githubCert, ofType: "cer")
            // print(pathToCert)
            self.configureURLSession()
            
            self.activityIndicator.hidesWhenStopped = true
        }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
        // MARK: Button actions
 
    @IBAction func nsurlSessionRequestHandler(_ sender: UIButton) {
        self.activityIndicator.startAnimating()
        self.urlSession?.dataTask(with: NSURL(string:self.urlTextField.text!)! as URL, completionHandler: { ( data,  response, error) -> Void in
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.responseTextView.text = error!.localizedDescription
                    self.responseTextView.textColor = UIColor.red
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self.responseTextView.text = String(data: data, encoding: String.Encoding.utf8)
                self.responseTextView.textColor = UIColor.black
            }
            
        }).resume()
    }
        
        private func _publicKeyForCertificate(certificate: SecCertificate) -> SecKey? {
            var publicKey: SecKey?

            let policy = SecPolicyCreateBasicX509()
            var trust: SecTrust?
            let trustCreationStatus = SecTrustCreateWithCertificates(certificate, policy, &trust)

            if let trust = trust, trustCreationStatus == errSecSuccess {
                publicKey = SecTrustCopyPublicKey(trust)
            }

            return publicKey
        }
    
        // MARK: SSL Config
        
        func configureURLSession() {
            self.urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        }
        
        // MARK: URL session delegate
        
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let serverTrust = challenge.protectionSpace.serverTrust
        let certificate = SecTrustGetCertificateAtIndex(serverTrust!, 0)
        
        // Set SSL policies for domain name check
        let policies = NSMutableArray();
        policies.add(SecPolicyCreateSSL(true, (challenge.protectionSpace.host as CFString)))
        SecTrustSetPolicies(serverTrust!, policies);
        
        // Evaluate server certificate
        var result: SecTrustResultType = SecTrustResultType(rawValue: 0)!
        SecTrustEvaluate(serverTrust!, &result)
        let isServerTrusted: Bool = (result == SecTrustResultType.unspecified || result == SecTrustResultType.proceed)
        
        // Get local and remote cert data
        let remoteCertificateData:NSData = SecCertificateCopyData(certificate!)
        let pathToCert = Bundle.main.path(forResource: githubCert, ofType: "cer")
        let localCertificate: NSData = NSData(contentsOfFile: pathToCert!)!
        
        if (isServerTrusted && remoteCertificateData.isEqual(to: localCertificate as Data)) {
            let credential: URLCredential = URLCredential(trust: serverTrust!)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }

}
