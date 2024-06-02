//
//  ChatRoomTableViewCell.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 6/2/24.
//

import UIKit

protocol ChatRoomTableViewCell: UITableViewCell {
    func configureCell(data: Chat)
}
