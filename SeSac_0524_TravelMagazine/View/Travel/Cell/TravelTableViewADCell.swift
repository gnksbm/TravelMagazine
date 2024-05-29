//
//  TravelTableViewADCell.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/27/24.
//

import UIKit

class TravelTableViewADCell: UITableViewCell, TravelTableViewCell {
    @IBOutlet var labelBackgroundView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var adLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureCell(data: Travel) {
        titleLabel.text = data.title
        titleLabel.font = .systemFont(ofSize: 15, weight: .black)
        labelBackgroundView.layer.cornerRadius = 8
        labelBackgroundView.clipsToBounds = true
        labelBackgroundView.backgroundColor = [#colorLiteral(red: 1, green: 0.8288480639, blue: 0.8279682994, alpha: 1), #colorLiteral(red: 0.8388726115, green: 1, blue: 0.8289427161, alpha: 1)].randomElement()
        
        adLabel.font = .systemFont(ofSize: 12)
        adLabel.layer.cornerRadius = 4
        adLabel.clipsToBounds = true
    }
    
    private func configureUI() {
        selectionStyle = .none
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
    }
}
