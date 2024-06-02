//
//  ChatRoomViewController.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 6/2/24.
//

import UIKit

final class ChatRoomViewController: UIViewController {
    private var chatList = [Chat]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let textViewFont = UIFont.systemFont(
        ofSize: 18,
        weight: .medium
    )
    private lazy var textViewPlaceholder = NSAttributedString(
        string: "메세지를 입력하세요",
        attributes: [
            .font: textViewFont,
            .foregroundColor: UIColor.gray
        ]
    )
    private var textViewHeightConstraint: NSLayoutConstraint!
    
    private var isScrolledOnViewWillAppear = false
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(ChatRoomTVLeadingCell.self)
        tableView.register(ChatRoomTVTrailingCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let newMessageBackgroundView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return view
    }()
    
    private lazy var newMessageTextView = {
        let textView = UITextView()
        textView.attributedText = textViewPlaceholder
        textView.backgroundColor = .clear
        textView.delegate = self
        return textView
    }()
    
    private lazy var sendMessageButton = {
        let button = UIButton(configuration: .plain())
        button.configuration?.image = UIImage(systemName: "arrowtriangle.right")
        button.configuration?.preferredSymbolConfigurationForImage
        = UIImage.SymbolConfiguration(pointSize: 20)
        button.configurationUpdateHandler = { button in
            button.tintColor = button.isEnabled ?
                .gray : .gray.withAlphaComponent(0.5)
        }
        button.isEnabled = false
        button.addTarget(
            self,
            action: #selector(sendButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureNavigation()
        hideKeyboardOnTap()
    }
    
    func configureChatList(dataList: [Chat]) {
        self.chatList = dataList
    }
    
    @objc private func sendButtonTapped(_ sender: UIButton) {
        chatList.append(
            Chat(
                user: .user,
                date: Date.now.formatted(dateFormat: .chatInput),
                message: newMessageTextView.text
            )
        )
        newMessageTextView.text.removeAll()
        sender.isEnabled = false
        tableView.scrollToRow(
            at: IndexPath(
                row: chatList.count - 1,
                section: tableView.numberOfSections - 1
            ),
            at: .bottom,
            animated: true
        )
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        
        [
            tableView,
            newMessageBackgroundView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        [
            newMessageTextView,
            sendMessageButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            newMessageBackgroundView.addSubview($0)
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        let textViewHeight = textViewFont.lineHeight
        + newMessageTextView.layoutMargins.top
        + newMessageTextView.layoutMargins.bottom
        textViewHeightConstraint = newMessageTextView.frameLayoutGuide
            .heightAnchor.constraint(
                equalToConstant: textViewHeight
            )
        let textViewPadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            newMessageBackgroundView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: 24
            ),
            newMessageBackgroundView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: -24
            ),
            newMessageBackgroundView.bottomAnchor.constraint(
                equalTo: view.keyboardLayoutGuide.topAnchor,
                constant: -16
            ),
            
            tableView.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: newMessageBackgroundView.topAnchor
            ),
            
            newMessageTextView.topAnchor.constraint(
                equalTo: newMessageBackgroundView.topAnchor,
                constant: textViewPadding
            ),
            newMessageTextView.leadingAnchor.constraint(
                equalTo: newMessageBackgroundView.leadingAnchor,
                constant: textViewPadding
            ),
            newMessageTextView.trailingAnchor.constraint(
                equalTo: sendMessageButton.leadingAnchor,
                constant: -textViewPadding
            ),
            newMessageTextView.bottomAnchor.constraint(
                equalTo: newMessageBackgroundView.bottomAnchor,
                constant: -textViewPadding
            ),
            textViewHeightConstraint,
            
            sendMessageButton.centerYAnchor.constraint(
                equalTo: newMessageBackgroundView.topAnchor,
                constant: textViewPadding + (textViewHeight / 2)
            ),
            sendMessageButton.trailingAnchor.constraint(
                equalTo: newMessageBackgroundView.trailingAnchor,
                constant: -textViewPadding
            ),
        ])
    }
}

extension ChatRoomViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.contentSize.height < textViewFont.lineHeight * 4 {
            textViewHeightConstraint.constant = textView.contentSize.height
        }
        sendMessageButton.isEnabled = !(textView.text.isEmpty ||
        textView.attributedText == textViewPlaceholder)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.attributedText == textViewPlaceholder {
            textView.text.removeAll()
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty == true {
            textView.attributedText = textViewPlaceholder
        }
    }
}

extension ChatRoomViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        if !isScrolledOnViewWillAppear {
            tableView.scrollToRow(
                at: IndexPath(
                    row: chatList.count - 1,
                    section: tableView.numberOfSections - 1
                ),
                at: .bottom,
                animated: false
            )
            isScrolledOnViewWillAppear = true
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }
}

extension ChatRoomViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        chatList.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let data = chatList[indexPath.row]
        var cell: ChatRoomTableViewCell
        if data.user == .user {
            cell = tableView.dequeueReusableCell(
                cellType: ChatRoomTVTrailingCell.self,
                for: indexPath
            )
        } else {
            cell = tableView.dequeueReusableCell(
                cellType: ChatRoomTVLeadingCell.self,
                for: indexPath
            )
        }
        cell.configureCell(data: data)
        return cell
    }
}
