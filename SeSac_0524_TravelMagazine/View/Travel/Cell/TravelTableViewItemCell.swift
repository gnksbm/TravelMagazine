//
//  TravelTableViewItemCell.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 5/27/24.
//

import UIKit

import Kingfisher

class TravelTableViewItemCell: UITableViewCell, TravelTableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var starStackView: UIStackView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var likeButtonBackgroundView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureCell(data: Travel) {
        titleLabel.text = data.title
        subtitleLabel.text = data.description
        if let saveCount = data.save {
            let saveStr = saveCount.formatted()
            descriptionLabel.text = "(\(saveStr)) · 저장 \(saveStr)"
        }
        if let imageUrlString = data.travel_image {
            mainImageView.kf.setImage(with: URL(string: imageUrlString))
        }
        if let like = data.like {
            let imageName = like ? "heart.fill" : "heart"
            likeButton.setImage(.init(systemName: imageName), for: .normal)
        }
        if let grade = data.grade {
            let starViewArr = starStackView.arrangedSubviews
            evaluteGrade(
                value: grade,
                maximum: starViewArr.count
            ) { index, isFullValue in
                print(index)
                if isFullValue {
                    starViewArr[index].tintColor = .systemYellow
                } else {
                    starViewArr[index].tintColor = .systemGray5
                }
            }
        }
    }
    
    private func evaluteGrade(
        value: Double,
        maximum: Int,
        closure: (_ index: Int, _ isFullValue: Bool) -> Void
    ) {
        let filledRange = Int(value)
        (0..<filledRange).forEach { index in
            closure(index, true)
        }
        (filledRange..<maximum).forEach { index in
            closure(index, false)
        }
    }
    
    private func configureUI() {
        titleLabel.font = .boldSystemFont(ofSize: 17)
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        subtitleLabel.textColor = .darkGray
        subtitleLabel.numberOfLines = 0
        descriptionLabel.font = .boldSystemFont(ofSize: 12)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.numberOfLines = 0
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 8
        mainImageView.clipsToBounds = true
        mainImageView.backgroundColor = .lightGray
        configureConstraint()
    }
    
    private func configureConstraint() {
        [
            titleLabel,
            subtitleLabel,
            starStackView,
            descriptionLabel,
            mainImageView,
            likeButtonBackgroundView,
            likeButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        guard let likeButtonImageView = likeButton.imageView else { return }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: mainImageView.topAnchor
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: mainImageView.leadingAnchor,
                constant: -24
            ),
            
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 2
            ),
            subtitleLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),
            subtitleLabel.trailingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor
            ),
            
            starStackView.centerYAnchor.constraint(
                equalTo: descriptionLabel.centerYAnchor
            ),
            starStackView.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),
            starStackView.heightAnchor.constraint(
                equalToConstant: 18
            ),
            starStackView.widthAnchor.constraint(
                equalTo: starStackView.heightAnchor,
                multiplier: 5
            ),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: subtitleLabel.bottomAnchor,
                constant: 8
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: starStackView.trailingAnchor,
                constant: 4
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor
            ),
            
            mainImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 20
            ),
            mainImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -24
            ),
            mainImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -20
            ),
            mainImageView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: 1/4
            ),
            mainImageView.heightAnchor.constraint(
                equalTo: mainImageView.widthAnchor,
                multiplier: 6/5
            ),
            
            likeButton.topAnchor.constraint(
                equalTo: mainImageView.topAnchor
            ),
            likeButton.trailingAnchor.constraint(
                equalTo: mainImageView.trailingAnchor
            ),
            likeButton.widthAnchor.constraint(
                equalTo: likeButton.heightAnchor
            ),
            
            likeButtonBackgroundView.topAnchor.constraint(
                equalTo: likeButtonImageView.topAnchor
            ),
            likeButtonBackgroundView.leadingAnchor.constraint(
                equalTo: likeButtonImageView.leadingAnchor
            ),
            likeButtonBackgroundView.trailingAnchor.constraint(
                equalTo: likeButtonImageView.trailingAnchor
            ),
            likeButtonBackgroundView.bottomAnchor.constraint(
                equalTo: likeButtonImageView.bottomAnchor
            ),
        ])
    }
}
