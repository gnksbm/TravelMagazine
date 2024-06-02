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
