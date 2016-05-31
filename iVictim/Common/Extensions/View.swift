//
//  View.swift
//  Tvm
//
//  Created by Azzaro Mujic on 25/04/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

extension UIView {
    
    var isOnMainWindow: Bool {
        if let windowFrame = UIApplication.sharedApplication().keyWindow?.frame {
            return CGRectContainsRect(windowFrame, frame)
        } else {
            return false
        }
    }
    
    @IBInspectable var borderWidth2: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set(borderWidth) {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor2: UIColor {
        get {
            return UIColor(CGColor: layer.borderColor ?? UIColor.clearColor().CGColor)
        }
        
        set(borderColor) {
            layer.borderColor = borderColor.CGColor
        }
    }
 
    @IBInspectable var cornerRadius2: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set(cornerRadius) {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    static func initViewWithOwner<T: UIView>(owner: AnyObject) -> T {
        let wrapedView = NSBundle.mainBundle().loadNibNamed(String(T), owner: owner, options: nil)[0]
        guard let view = wrapedView as? T else {
            fatalError("Couldn’t instantiate view from nib with identifier \(String(T))")
        }
        
        return view
    }
    
}