//
//  UITableView+.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/25/24.
//

import UIKit

extension UITableView {
    func register(_ cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(
        _ cellClass: T.Type,
        for indexPath: IndexPath
    ) -> T {
        dequeueReusableCell(
            withIdentifier: cellClass.identifier,
            for: indexPath
        ) as! T
    }
}

fileprivate extension UITableViewCell {
    static var identifier: String { String(describing: Self.self) }
}
