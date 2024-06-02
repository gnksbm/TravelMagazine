//
//  TravelViewController.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/27/24.
//

import UIKit

final class TravelViewController: UIViewController {
    private let list = TravelInfo().travel
    
    @IBOutlet var travelTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        travelTableView.dataSource = self
        travelTableView.delegate = self
        travelTableView.registerNib(TravelTableViewItemCell.self)
        travelTableView.registerNib(TravelTableViewADCell.self)
        travelTableView.rowHeight = UITableView.automaticDimension
        travelTableView.estimatedRowHeight = 152
    }
}

extension TravelViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        list.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let data = list[indexPath.row]
        var cell: TravelTableViewCell
        if data.ad {
            cell = tableView.dequeueReusableCell(
                cellType: TravelTableViewADCell.self,
                for: indexPath
            )
        } else {
            cell = tableView.dequeueReusableCell(
                cellType: TravelTableViewItemCell.self,
                for: indexPath
            )
        }
        cell.configureCell(
            data: data
        )
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let data = list[indexPath.row]
        if data.ad {
            let vc = ADViewController()
            let navigationController = UINavigationController(
                rootViewController: vc
            )
            navigationController.modalPresentationStyle = .fullScreen
            vc.title = "광고 화면"
            let xButton = UIBarButtonItem(
                image: UIImage(systemName: "xmark")?
                    .withConfiguration(
                        UIImage.SymbolConfiguration(
                            font: .boldSystemFont(ofSize: 15)
                        )
                    ),
                primaryAction: UIAction {
                    _ in
                    navigationController.dismiss(animated: true)
                }
            )
            xButton.tintColor = .black
            vc.navigationItem.leftBarButtonItem = xButton
            present(navigationController, animated: true)
        } else {
            let vc = TravelDetailViewController()
            vc.title = "관광지 화면"
            navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.backButtonTitle = nil
        }
    }
}
