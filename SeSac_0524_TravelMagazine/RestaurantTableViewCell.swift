//
//  RestaurantTableViewCell.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/24/24.
//

import UIKit

final class RestaurantTableViewCell: UITableViewCell {
    private let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20)
    
    private let largeImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.lineBreakMode = .byCharWrapping
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.setContentHuggingPriority(
            .init(999),
            for: .horizontal
        )
        return label
    }()
    
    private let categoryLabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.setContentCompressionResistancePriority(
            .init(999),
            for: .horizontal
        )
        return label
    }()
    
    private lazy var callButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "phone.fill")?
            .withConfiguration(imageConfiguration)
        configuration.baseForegroundColor = .green
        let button = UIButton(configuration: configuration)
        button.setContentCompressionResistancePriority(
            .init(999),
            for: .horizontal
        )
        return button
    }()
    
    private lazy var directionButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "location.fill")?
            .withConfiguration(imageConfiguration)
        configuration.baseForegroundColor = .systemTeal
        let button = UIButton(configuration: configuration)
        button.setContentCompressionResistancePriority(
            .init(999),
            for: .horizontal
        )
        return button
    }()
    
    private let addressLabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        largeImageView.image = nil
        [nameLabel, addressLabel, categoryLabel].forEach {
            $0.text = nil
        }
    }
    
    func configureCell(restaurant: Restaurant) {
        largeImageView.kf.setImage(with: URL(string: restaurant.image))
        nameLabel.text = restaurant.name
        categoryLabel.text = restaurant.category
        addressLabel.text = restaurant.address
    }
    
    private func configureUI() {
        [
            largeImageView,
            nameLabel,
            addressLabel,
            categoryLabel,
            callButton,
            directionButton
        ].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.topAnchor,
                constant: 8
            ),
            nameLabel.leadingAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.leadingAnchor
            ),
            
            categoryLabel.firstBaselineAnchor.constraint(
                equalTo: nameLabel.firstBaselineAnchor
            ),
            categoryLabel.leadingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor,
                constant: 8
            ),
            categoryLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: callButton.leadingAnchor,
                constant: -12
            ),
            
            addressLabel.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: 4
            ),
            addressLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),
            addressLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: categoryLabel.trailingAnchor
            ),
            
            callButton.topAnchor.constraint(
                equalTo: nameLabel.topAnchor
            ),
            callButton.trailingAnchor.constraint(
                equalTo: directionButton.leadingAnchor,
                constant: -8
            ),
            
            directionButton.topAnchor.constraint(
                equalTo: callButton.topAnchor
            ),
            directionButton.trailingAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.trailingAnchor
            ),
            
            largeImageView.topAnchor.constraint(
                equalTo: addressLabel.bottomAnchor,
                constant: 24
            ),
            largeImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            largeImageView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor
            ),
            largeImageView.heightAnchor.constraint(
                equalTo: largeImageView.widthAnchor
            ),
            largeImageView.bottomAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.bottomAnchor,
                constant: -8
            ),
        ])
    }

}
