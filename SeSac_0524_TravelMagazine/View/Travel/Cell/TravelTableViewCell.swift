//
//  TravelTableViewCell.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/28/24.
//

import UIKit

protocol TravelTableViewCell: UITableViewCell {
    func configureCell(data: Travel)
}
