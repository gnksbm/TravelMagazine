//
//  MagazineTableViewCell.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/24/24.
//

import UIKit
import Kingfisher

final class MagazineTableViewCell: UITableViewCell {
    private let largeImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    private let subtitleLabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .regular)
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
        [titleLabel, subtitleLabel, dateLabel].forEach {
            $0.text = nil
        }
    }
    
    func configureCell(magazine: Magazine) {
        largeImageView.kf.setImage(with: URL(string: magazine.photo_image))
        titleLabel.text = magazine.title
        subtitleLabel.text = magazine.subtitle
        dateLabel.text = magazine.formattedDate
    }
    
    private func configureUI() {
        [largeImageView, titleLabel, subtitleLabel, dateLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            largeImageView.topAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.topAnchor,
                constant: 8
            ),
            largeImageView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            largeImageView.widthAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.widthAnchor
            ),
            largeImageView.heightAnchor.constraint(
                equalTo: largeImageView.widthAnchor
            ),
            
            titleLabel.topAnchor.constraint(
                equalTo: largeImageView.bottomAnchor,
                constant: 16
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: largeImageView.leadingAnchor
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: largeImageView.trailingAnchor
            ),
            
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8
            ),
            subtitleLabel.leadingAnchor.constraint(
                equalTo: largeImageView.leadingAnchor
            ),
            subtitleLabel.trailingAnchor.constraint(
                equalTo: largeImageView.trailingAnchor
            ),
            
            dateLabel.topAnchor.constraint(
                equalTo: subtitleLabel.bottomAnchor,
                constant: 8
            ),
            dateLabel.trailingAnchor.constraint(
                equalTo: largeImageView.trailingAnchor
            ),
            dateLabel.bottomAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.bottomAnchor,
                constant: -8
            )
        ])
    }
}
