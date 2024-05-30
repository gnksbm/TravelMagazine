//
//  RestaurantListViewController.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/24/24.
//

import UIKit

final class RestaurantListViewController: UIViewController {
    private let list = RestaurantList().restaurantArray
    private lazy var filteredList = list {
        didSet {
            restaurantTableView.reloadData()
        }
    }
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var restaurantTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
        configureNavigation()
    }
    
    private func configureTableView() {
        restaurantTableView.register(RestaurantTableViewCell.self)
        restaurantTableView.separatorStyle = .none
        restaurantTableView.dataSource = self
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = makeFilterMenuButton(
            originalList: list
        ) { result in
            self.filteredList = result
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "map"),
            primaryAction: UIAction { _ in
                self.navigationController?.pushViewController(
                    MapViewController(),
                    animated: true
                )
            }
        )
    }
}
// MARK: SearchBar
extension RestaurantListViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        guard !searchText.isEmpty else {
            filteredList = list
            return
        }
        filteredList = list.filter { item in
            item.name.contains(searchText) ||
            item.category.contains(searchText)
        }
    }
}
// MARK: TableView
extension RestaurantListViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        filteredList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            cellType: RestaurantTableViewCell.self,
            for: indexPath
        )
        cell.configureCell(
            restaurant: filteredList[indexPath.row]
        )
        return cell
    }
}
