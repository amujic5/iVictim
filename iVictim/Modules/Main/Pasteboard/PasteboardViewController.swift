//
//  PasteboardViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 03/06/16.
//
//

import UIKit

final class PasteboardViewController: UIViewController {

    @IBOutlet weak var responseTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showPasteboardItems(sender: UIButton) {
        _showPaseboardItemsOnScreen()
    }
    func _showPaseboardItemsOnScreen() {
        let pasteboardItems = UIPasteboard.generalPasteboard().items
        
        let text = pasteboardItems.reduce("") { (text, object) -> String in
            text + "\n" + String(object)
        }
        
        responseTextView.text = text
    }
}
