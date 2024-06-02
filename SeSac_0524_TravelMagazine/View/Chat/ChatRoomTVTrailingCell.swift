//
//  ChatRoomTVTrailingCell.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 6/2/24.
//

import UIKit

final class ChatRoomTVTrailingCell: UITableViewCell, ChatRoomTableViewCell {
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
        view.backgroundColor = .secondarySystemFill
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [messageLabel ,dateLabel].forEach {
            $0.text = nil
        }
    }
    
    func configureCell(data: Chat) {
        messageLabel.text = data.message
        dateLabel.text = data.visibleDate
    }
    
    private func configureLayout() {
        selectionStyle = .none
        
        [
            messageBackgroundView,
            messageLabel,
            dateLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        let messagePadding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(
                greaterThanOrEqualTo: contentView.leadingAnchor,
                constant: 24
            ),
            dateLabel.bottomAnchor.constraint(
                equalTo: messageBackgroundView.bottomAnchor
            ),
            
            messageBackgroundView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),
            messageBackgroundView.leadingAnchor.constraint(
                equalTo: dateLabel.trailingAnchor,
                constant: 8
            ),
            messageBackgroundView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            messageBackgroundView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -16
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
