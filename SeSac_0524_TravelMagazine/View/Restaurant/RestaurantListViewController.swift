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
        restaurantTableView.register(RestaurantTableViewCell.self)
        restaurantTableView.separatorStyle = .none
        restaurantTableView.dataSource = self
        searchBar.delegate = self
        
        navigationItem.leftBarButtonItem = makeMenuButton()
    }
    
    private func makeMenuButton() -> UIBarButtonItem {
        let buttonNames = Set(list.map { $0.category })
        var children = buttonNames.map { title in
            UIAction(title: "\(title)") { [self] action in
                filteredList = list.filter { title == $0.category }
                showAlert(message: "\(filteredList.count)개의 결과가 있습니다")
            }
        }
        let allAction = UIAction(title: "전체보기") { [self] _ in
            filteredList = list
        }
        children.insert(allAction, at: 0)
        let menu = UIMenu(title: "음식종류", children: children)
        let barButton = UIBarButtonItem(
            image: .init(systemName: "line.3.horizontal.decrease.circle"),
            menu: menu
        )
        barButton.tintColor = .black
        return barButton
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
