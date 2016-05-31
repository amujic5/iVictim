//
//  Storyboard.swift
//  Tvm
//
//  Created by Azzaro Mujic on 23/03/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import Foundation
import Foundation
import UIKit

//MARK: UIViewController identifiers
protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(self)
    }
}

extension UIViewController : StoryboardIdentifiable { }

extension UIStoryboard {
    func instantiateViewController<T: UIViewController where T: StoryboardIdentifiable>() -> T {
        let optionalViewController = self.instantiateViewControllerWithIdentifier(T.storyboardIdentifier)
        
        guard let viewController = optionalViewController as? T  else {
            fatalError("Couldn’t instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}
