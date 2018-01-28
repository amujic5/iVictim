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
        if let windowFrame = UIApplication.shared.keyWindow?.frame {
            return windowFrame.contains(frame)
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
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        
        set(borderColor) {
            layer.borderColor = borderColor.cgColor
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
        let wrapedView = Bundle.main.loadNibNamed(String(describing: T.self), owner: owner, options: nil)![0]
        guard let view = wrapedView as? T else {
            fatalError("Couldn’t instantiate view from nib with identifier \(String(describing: T.self))")
        }
        
        return view
    }
    
}
