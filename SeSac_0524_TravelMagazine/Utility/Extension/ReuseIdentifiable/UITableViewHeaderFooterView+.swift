//
//  UITableViewHeaderFooterView+.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/28/24.
//

import UIKit

extension UITableViewHeaderFooterView: ReuseIdentifiable { }

extension UITableView {
    func register<T: UITableViewHeaderFooterView>(
        _ headerFooterViewType: T.Type
    ) {
        register(
            headerFooterViewType,
            forHeaderFooterViewReuseIdentifier: headerFooterViewType.identifier
        )
    }
    
    func registerNib<T: UITableViewHeaderFooterView>(
        _ headerFooterViewType: T.Type
    ) {
        register(
            UINib(nibName: headerFooterViewType.identifier, bundle: nil),
            forHeaderFooterViewReuseIdentifier: headerFooterViewType.identifier
        )
    }
    
    func dequeueReusableCell<T: UITableViewHeaderFooterView>(
        headerFooterViewType: T.Type
    ) -> T {
        dequeueReusableHeaderFooterView(
            withIdentifier: headerFooterViewType.identifier
        ) as! T
    }
}
