//
//  CellMagic.swift
//  Tvm
//
//  Created by Azzaro Mujic on 23/03/16.
//  Copyright © 2016 Infinum. All rights reserved.
//

import UIKit

//MARK: UIViewController identifiers
protocol CellIdentifiable {
    static var cellIdentifier: String { get }
}

extension CellIdentifiable where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension CellIdentifiable where Self: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: CellIdentifiable { }
extension UICollectionViewCell: CellIdentifiable {}

extension UITableView {
    
    func dequeueCellAtIndexPath<T: UITableViewCell>(indexPath: NSIndexPath) -> T where T: CellIdentifiable {
        return dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath as IndexPath) as! T
    }
    
}

extension UICollectionView {
    
    func dequeueCellAtIndexPath<T: UICollectionViewCell>(indexPath: NSIndexPath) -> T where T: CellIdentifiable {
        return dequeueReusableCell(withReuseIdentifier: T.cellIdentifier, for: indexPath as IndexPath) as! T
    }
    
}
