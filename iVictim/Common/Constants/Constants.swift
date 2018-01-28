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
    return UIScreen.main.bounds.width
}

func screenHeight() -> CGFloat {
    return UIScreen.main.bounds.height
}

func delay(seconds: Double, completion:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
    
}
