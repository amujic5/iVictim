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
    var urlSession: NSURLSession = NSURLSession.sharedSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func httpsButtonClicked(sender: UIButton) {
        _doRequestWithURL(sender.titleLabel!.text!)
    }
    
    @IBAction func httpButtonClicked(sender: UIButton) {
        _doRequestWithURL(sender.titleLabel!.text!)
    }
    
    
    private func _doRequestWithURL(url: String) {
        self.activityIndicator.startAnimating()
        self.urlSession.dataTaskWithURL(NSURL(string:url)!, completionHandler: { ( data,  response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.activityIndicator.stopAnimating()
            })
            
            guard let data = data where error == nil else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.textView.text = error!.description
                    self.textView.textColor = UIColor.redColor()
                })
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.textView.text = String(data: data, encoding: NSUTF8StringEncoding)
                self.textView.textColor = UIColor.blackColor()
            })
        }).resume()
    }


}
