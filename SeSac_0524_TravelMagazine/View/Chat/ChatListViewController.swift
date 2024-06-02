//
//  ChatListViewController.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 6/2/24.
//

import UIKit

final class ChatListViewController: UIViewController {
    private lazy var filteredList = mockChatList {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var searchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(ChatListTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureNavigation()
    }
    
    private func configureNavigation() {
        navigationItem.title = "TRAVEL TALK"
        navigationItem.searchController = UISearchController()
        let placeholder = NSAttributedString(
            string: "친구 이름을 검색해보세요",
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 18,
                    weight: .medium
                )
            ]
        )
        navigationItem.searchController?.searchBar
            .searchTextField.attributedPlaceholder = placeholder
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.preferredSearchBarPlacement = .stacked
    }
    
    private func configureLayout() {
        [searchBar, tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}

extension ChatListViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        guard !searchText.isEmpty else {
            filteredList = mockChatList
            return
        }
        filteredList = mockChatList.search(contain: searchText)
    }
}

extension ChatListViewController: UITableViewDataSource {
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
            cellType: ChatListTableViewCell.self,
            for: indexPath
        )
        let data = filteredList[indexPath.row]
        cell.configureCell(data: data)
        return cell
    }
}

extension ChatListViewController: UITableViewDelegate { 
    
}
