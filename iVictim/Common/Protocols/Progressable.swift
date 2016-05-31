//
//  Progressable.swift
//  iVictim
//
//  Created by Azzaro Mujic on 5/31/16
//  Copyright (c) 2016 . All rights reserved.
//

import UIKit

protocol Progressable {
    func showLoading()
    func hideLoading()
}

extension Progressable where Self: UIViewController {
    
    func showLoading() {
    }
    
    func hideLoading() {
    }
    
}
