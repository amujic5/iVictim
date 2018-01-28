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
        return String(describing: self)
    }
}

extension UIViewController : StoryboardIdentifiable { }

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        let optionalViewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier)
        
        guard let viewController = optionalViewController as? T  else {
            fatalError("Couldn’t instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}
