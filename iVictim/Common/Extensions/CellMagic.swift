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
        return String(self)
    }
}

extension CellIdentifiable where Self: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(self)
    }
}

extension UITableViewCell: CellIdentifiable { }
extension UICollectionViewCell: CellIdentifiable {}

extension UITableView {
    
    func dequeueCellAtIndexPath<T: UITableViewCell where T: CellIdentifiable>(indexPath: NSIndexPath) -> T {
        return dequeueReusableCellWithIdentifier(T.cellIdentifier, forIndexPath: indexPath) as! T
    }
    
}

extension UICollectionView {
    
    func dequeueCellAtIndexPath<T: UICollectionViewCell where T: CellIdentifiable>(indexPath: NSIndexPath) -> T {
        return dequeueReusableCellWithReuseIdentifier(T.cellIdentifier, forIndexPath: indexPath) as! T
    }
    
}