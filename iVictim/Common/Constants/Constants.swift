//
//  Constants.swift
//  iVictim
//
//  Created by Azzaro Mujic on 5/31/16
//  Copyright (c) 2016 . All rights reserved.
//

import Foundation

// MARK: - View Controller Identifier -

// MARK: - Endpoints -
import UIKit

func screenWidth() -> CGFloat {
    return UIScreen.mainScreen().bounds.width
}

func screenHeight() -> CGFloat {
    return UIScreen.mainScreen().bounds.height
}

func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
    
}