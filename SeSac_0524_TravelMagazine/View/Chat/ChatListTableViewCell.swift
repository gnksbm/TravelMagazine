//
//  ChatListTableViewCell.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 6/2/24.
//

import UIKit

final class ChatListTableViewCell: UITableViewCell {
    private let mainImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let roomNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .heavy)
        return label
    }()
    
    private let lastestMessageLabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let lastestDateLabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .right
        label.setContentHuggingPriority(
            .defaultLow,
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
        mainImageView.layer.cornerRadius = mainImageView.bounds.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
        [roomNameLabel, lastestMessageLabel, lastestDateLabel].forEach {
            $0.text = nil
        }
    }
    
    func configureCell(data: ChatRoom) {
        mainImageView.image = data.mainImage
        roomNameLabel.text = data.chatroomName
        lastestMessageLabel.text = data.lastestMessage
        lastestDateLabel.text = data.latestDate
    }
    
    private func configureLayout() {
        selectionStyle = .none
        
        [
            mainImageView,
            roomNameLabel,
            lastestMessageLabel,
            lastestDateLabel,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        let mainImageHeightConstraint = mainImageView.heightAnchor.constraint(
            equalTo: mainImageView.widthAnchor
        )
        mainImageHeightConstraint.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),
            mainImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 24
            ),
            mainImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16
            ),
            mainImageView.widthAnchor.constraint(
                equalToConstant: 60
            ),
            mainImageHeightConstraint,
            
            roomNameLabel.leadingAnchor.constraint(
                equalTo: mainImageView.trailingAnchor,
                constant: 8
            ),
            roomNameLabel.trailingAnchor.constraint(
                equalTo: lastestDateLabel.leadingAnchor,
                constant: -16
            ),
            roomNameLabel.bottomAnchor.constraint(
                equalTo: contentView.centerYAnchor,
                constant: -4
            ),
            
            lastestMessageLabel.leadingAnchor.constraint(
                equalTo: roomNameLabel.leadingAnchor
            ),
            lastestMessageLabel.trailingAnchor.constraint(
                equalTo: roomNameLabel.trailingAnchor
            ),
            lastestMessageLabel.topAnchor.constraint(
                equalTo: contentView.centerYAnchor,
                constant: 4
            ),
            
            lastestDateLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),
            lastestDateLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -24
            ),
        ])
    }
}
