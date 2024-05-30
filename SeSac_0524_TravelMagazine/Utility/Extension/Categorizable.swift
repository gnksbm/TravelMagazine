//
//  Categorizable.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/31/24.
//

import UIKit

protocol Categorizable {
    associatedtype Category: Hashable
    var category: Category { get }
}

extension UIViewController {
    func makeFilterMenuButton<T: Categorizable>(
        originalList: [T],
        filteredHandler: @escaping (_ filteredList: [T]) -> Void,
        unfilteredHandler: ((_ unfilteredList: [T]) -> Void)? = nil
    ) -> UIBarButtonItem {
        let categories = Set(originalList.map { $0.category })
        var menuActions = categories.map { title in
            UIAction(title: "\(title)") { _ in
                let filteredList = originalList.filter {
                    title == $0.category
                }
                filteredHandler(filteredList)
            }
        }
        let unfilterAction = UIAction(title: "전체보기") { _ in
            unfilteredHandler?(originalList)
        }
        menuActions.insert(unfilterAction, at: 0)
        let menu = UIMenu(title: "음식종류", children: menuActions)
        let barButton = UIBarButtonItem(
            title: "Filter",
            menu: menu
        )
        return barButton
    }
}
