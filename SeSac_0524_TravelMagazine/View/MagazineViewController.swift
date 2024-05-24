//
//  MagazineViewController.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/24/24.
//

import UIKit

final class MagazineViewController: UITableViewController {
    private let magazineInfo = MagazineInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MagazineTableViewCell.self)
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

// MARK: TableView
extension MagazineViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        magazineInfo.magazine.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            MagazineTableViewCell.self,
            for: indexPath
        )
        cell.configureCell(magazine: magazineInfo.magazine[indexPath.row])
        return cell
    }
}
