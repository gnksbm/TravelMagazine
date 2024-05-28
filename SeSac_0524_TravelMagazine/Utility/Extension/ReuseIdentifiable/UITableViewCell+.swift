//
//  UITableViewCell+.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/28/24.
//

import UIKit

extension UITableViewCell: ReuseIdentifiable { }

extension UITableView {
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        register(
            cellType,
            forCellReuseIdentifier: cellType.identifier
        )
    }
    
    func registerNib<T: UITableViewCell>(_ cellType: T.Type) {
        print(cellType.identifier)
        register(
            UINib(nibName: cellType.identifier, bundle: nil),
            forCellReuseIdentifier: cellType.identifier
        )
    }
    
    func dequeueReusableCell<T: UITableViewCell>(
        cellType: T.Type,
        for indexPath: IndexPath
    ) -> T {
        dequeueReusableCell(
            withIdentifier: cellType.identifier,
            for: indexPath
        ) as! T
    }
}
