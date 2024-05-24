//
//  RestaurantListViewController.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/24/24.
//

import UIKit

final class RestaurantListViewController: UITableViewController {
    private let restaurantList = RestaurantList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RestaurantTableViewCell.self)
        tableView.separatorStyle = .none
    }
}

// MARK: TableView
extension RestaurantListViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        restaurantList.restaurantArray.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            RestaurantTableViewCell.self,
            for: indexPath
        )
        cell.configureCell(
            restaurant: restaurantList.restaurantArray[indexPath.row]
        )
        return cell
    }
}
