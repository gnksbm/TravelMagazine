//
//  ViewController.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/24/24.
//

import UIKit

final class ViewController: UIViewController {
    let tableViewData = MagazineInfo()
    
    private lazy var magazineTableView = {
        let tableView = UITableView()
        tableView.register(MagazineTableViewCell.self, forCellReuseIdentifier: "MagazineTableViewCell")
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.addSubview(magazineTableView)
        magazineTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            magazineTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            magazineTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            magazineTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            magazineTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        tableViewData.magazine.count
    }
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineTableViewCell", for: indexPath) as! MagazineTableViewCell
        cell.configureCell(magazine: tableViewData.magazine[indexPath.row])
        return cell
    }
}
