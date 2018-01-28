//
//  TransportLayerSecurityViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 02/06/16.
//
//

import UIKit

final class TransportLayerSecurityViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var urlSession: URLSession {
        return URLSession.shared
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func httpsButtonClicked(_ sender: UIButton) {
        _doRequestWithURL(url: sender.titleLabel!.text!)
    }
    
    @IBAction func httpButtonClicked(_ sender: UIButton) {
        _doRequestWithURL(url: sender.titleLabel!.text!)
    }
    
    
    private func _doRequestWithURL(url: String) {
        self.activityIndicator.startAnimating()
        self.urlSession.dataTask(with: URL(string:url)! as URL, completionHandler: { ( data,  response, error) -> Void in

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    //self.textView.text = error
                    self.textView.textColor = UIColor.red
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self.textView.text = String(data: data, encoding: String.Encoding.utf8)
                self.textView.textColor = UIColor.black
            }

        }).resume()
    }


}
