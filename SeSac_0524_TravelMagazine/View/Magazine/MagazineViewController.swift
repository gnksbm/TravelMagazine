//
//  MagazineViewController.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/24/24.
//

import UIKit

final class MagazineViewController: UIViewController {
    private let magazineList = MagazineInfo().magazine
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MagazineTableViewCell.self)
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

// MARK: TableView
extension MagazineViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        magazineList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            cellType: MagazineTableViewCell.self,
            for: indexPath
        )
        cell.configureCell(magazine: magazineList[indexPath.row])
        return cell
    }
}
