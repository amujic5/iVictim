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
    
    @IBAction func clearPasteboardItemsButtonClicked(_ sender: UIButton) {
        _clearPasteboard()
    }

    @IBAction func showPasteboardItems(_ sender: UIButton) {
        _showPaseboardItemsOnScreen()
    }
    func _showPaseboardItemsOnScreen() {
        let pasteboardItems = UIPasteboard.general.items
        
        let text = pasteboardItems.reduce("") { (text, object) -> String in
            text + "\n" + String(describing: object)
        }
        
        responseTextView.text = text
    }
    
    private func _clearPasteboard() {
        UIPasteboard.general.items = []
    }
}
