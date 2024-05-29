//
//  CityTableViewCell.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/29/24.
//

import UIKit

import Kingfisher

final class CityTableViewCell: UITableViewCell {
    private let nameLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let cardImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = CACornerMask(
            arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner
        )
        return imageView
    }()
    
    private lazy var imageShadowView = {
        let view = UIView()
        view.layer.maskedCorners = cardImageView.layer.maskedCorners
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    private let explainLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    private let explainLabelBackgroundView = {
        let view = UIView()
        view.backgroundColor = .darkGray.withAlphaComponent(0.8)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardImageView.image = nil
        [nameLabel, explainLabel].forEach { $0.text = nil }
    }
    
    func configureCell(data: City) {
        nameLabel.text = data.name
        cardImageView.kf.setImage(with: data.imageURL)
        explainLabel.text = data.city_explain
    }
    
    private func configureLayout() {
        [
            imageShadowView,
            cardImageView,
            nameLabel,
            explainLabelBackgroundView,
            explainLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [
            imageShadowView,
            nameLabel,
            explainLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        imageShadowView.addSubview(cardImageView)
        cardImageView.addSubview(explainLabelBackgroundView)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(
                equalTo: cardImageView.topAnchor,
                constant: 12
            ),
            nameLabel.trailingAnchor.constraint(
                equalTo: cardImageView.trailingAnchor,
                constant: -12
            ),
            
            imageShadowView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8
            ),
            imageShadowView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            imageShadowView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            imageShadowView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -8
            ),
            imageShadowView.heightAnchor.constraint(
                equalToConstant: 160
            ),
            
            cardImageView.topAnchor.constraint(
                equalTo: imageShadowView.topAnchor
            ),
            cardImageView.leadingAnchor.constraint(
                equalTo: imageShadowView.leadingAnchor
            ),
            cardImageView.trailingAnchor.constraint(
                equalTo: imageShadowView.trailingAnchor
            ),
            cardImageView.bottomAnchor.constraint(
                equalTo: imageShadowView.bottomAnchor
            ),
            
            explainLabelBackgroundView.leadingAnchor.constraint(
                equalTo: cardImageView.leadingAnchor
            ),
            explainLabelBackgroundView.trailingAnchor.constraint(
                equalTo: cardImageView.trailingAnchor
            ),
            explainLabelBackgroundView.bottomAnchor.constraint(
                equalTo: cardImageView.bottomAnchor
            ),
            
            explainLabel.topAnchor.constraint(
                equalTo: explainLabelBackgroundView.topAnchor,
                constant: 8
            ),
            explainLabel.leadingAnchor.constraint(
                equalTo: explainLabelBackgroundView.leadingAnchor,
                constant: 8
            ),
            explainLabel.trailingAnchor.constraint(
                equalTo: explainLabelBackgroundView.trailingAnchor,
                constant: -8
            ),
            explainLabel.bottomAnchor.constraint(
                equalTo: explainLabelBackgroundView.bottomAnchor,
                constant: -8
            ),
        ])
    }
}
