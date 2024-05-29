//
//  TravelDetailViewController.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/29/24.
//

import UIKit

final class TravelDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceHolderView(message: "관광지 화면")
        navigationController?.navigationBar.topItem?.title = ""
    }
}

extension UIViewController {
    func setPlaceHolderView(message: String) {
        let label = UILabel()
        label.text = message
        label.font = .boldSystemFont(ofSize: 30)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        view.backgroundColor = .white
    }
}
