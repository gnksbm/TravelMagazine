//
//  CityViewController.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/29/24.
//

import UIKit

final class CityViewController: UIViewController {
    private let list = CityInfo().city
    private lazy var filteredList = list {
        didSet {
            cityTableView.reloadData()
        }
    }
    
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSegment()
        configureTableView()
    }
    
    private func configureSegment() {
        segmentControl.removeAllSegments()
        AreaType.allCases.forEach { areaType in
            segmentControl.insertSegment(
                withTitle: areaType.title,
                at: areaType.rawValue,
                animated: true
            )
        }
        segmentControl.selectedSegmentIndex = 0
        segmentControl.setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: 16, weight: .black)],
            for: .selected
        )
        segmentControl.setTitleTextAttributes(
            [.font: UIFont.boldSystemFont(ofSize: 15)],
            for: .normal
        )
        segmentControl.addTarget(
            self,
            action: #selector(segmentValueChanged),
            for: .valueChanged
        )
    }
    
    private func configureTableView() {
        cityTableView.register(CityTableViewCell.self)
        cityTableView.dataSource = self
        cityTableView.separatorStyle = .none
    }
    
    @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
        switch AreaType.allCases[sender.selectedSegmentIndex] {
        case .all:
            filteredList = list
        case .domestic:
            filteredList = list.filter { data in
                data.domestic_travel
            }
        case .international:
            filteredList = list.filter { data in
                !data.domestic_travel
            }
        }
    }
}

extension CityViewController: UITableViewDataSource {
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
            cellType: CityTableViewCell.self,
            for: indexPath
        )
        let data = filteredList[indexPath.row]
        cell.configureCell(data: data)
        return cell
    }
}

extension CityViewController {
    enum AreaType: Int, CaseIterable {
        case all, domestic, international
        
        var title: String {
            switch self {
            case .all:
                return "모두"
            case .domestic:
                return "국내"
            case .international:
                return "해외"
            }
        }
    }
}
