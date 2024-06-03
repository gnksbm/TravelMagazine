//
//  ChatRoomTVLeadingCell.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 6/2/24.
//

import UIKit

final class ChatRoomTVLeadingCell: UITableViewCell, ChatRoomTableViewCell {
    private let profileImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let userNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let messageLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let messageBackgroundView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.setContentCompressionResistancePriority(
            UILayoutPriority(999),
            for: .horizontal
        )
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        [userNameLabel, messageLabel, dateLabel].forEach {
            $0.text = nil
        }
    }
    
    func configureCell(data: Chat) {
        profileImageView.image = data.user.visibleImage
        userNameLabel.text = data.user.rawValue
        messageLabel.text = data.message
        dateLabel.text = data.visibleDate
    }
    
    private func configureLayout() {
        selectionStyle = .none
        
        [
            profileImageView,
            userNameLabel,
            messageLabel,
            messageBackgroundView,
            dateLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        let profileImageHeightConstraint
        = profileImageView.heightAnchor.constraint(equalToConstant: 40)
        profileImageHeightConstraint.priority = UILayoutPriority(999)
        
        let messagePadding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor, 
                constant: 16
            ),
            profileImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 24
            ),
            profileImageView.widthAnchor.constraint(
                equalTo: profileImageView.heightAnchor
            ),
            profileImageHeightConstraint,
            
            userNameLabel.topAnchor.constraint(
                equalTo: profileImageView.topAnchor
            ),
            userNameLabel.leadingAnchor.constraint(
                equalTo: profileImageView.trailingAnchor,
                constant: 8
            ),
            
            messageBackgroundView.topAnchor.constraint(
                equalTo: userNameLabel.bottomAnchor,
                constant: 8
            ),
            messageBackgroundView.leadingAnchor.constraint(
                equalTo: userNameLabel.leadingAnchor
            ),
            messageBackgroundView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16
            ),
            
            dateLabel.leadingAnchor.constraint(
                equalTo: messageBackgroundView.trailingAnchor,
                constant: 8
            ),
            dateLabel.bottomAnchor.constraint(
                equalTo: messageBackgroundView.bottomAnchor
            ),
            dateLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.trailingAnchor,
                constant: -24
            ),
            
            messageLabel.topAnchor.constraint(
                equalTo: messageBackgroundView.topAnchor,
                constant: messagePadding + 1
            ),
            messageLabel.leadingAnchor.constraint(
                equalTo: messageBackgroundView.leadingAnchor,
                constant: messagePadding
            ),
            messageLabel.trailingAnchor.constraint(
                equalTo: messageBackgroundView.trailingAnchor,
                constant: -messagePadding
            ),
            messageLabel.bottomAnchor.constraint(
                equalTo: messageBackgroundView.bottomAnchor,
                constant: -messagePadding - 1
            ),
        ])
    }
}
