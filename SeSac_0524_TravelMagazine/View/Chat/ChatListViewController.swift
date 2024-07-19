//
//  ChatListViewController.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 6/2/24.
//

import UIKit

final class ChatListViewController: UIViewController {
    private lazy var chatListCV = {
        let collectionView = ChatListCollectionView()
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureNavigation()
        chatListCV.updateSnapshot()
    }
    
    private func configureNavigation() {
        navigationItem.title = "TRAVEL TALK"
        navigationItem.searchController = UISearchController()
        let placeholder = NSAttributedString(
            string: "친구 이름을 검색해보세요",
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 18,
                    weight: .medium
                )
            ]
        )
        navigationItem.searchController?.searchBar
            .searchTextField.attributedPlaceholder = placeholder
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.preferredSearchBarPlacement = .stacked
    }
    
    private func configureLayout() {
        [chatListCV].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            chatListCV.topAnchor.constraint(
                equalTo: safeArea.topAnchor
            ),
            chatListCV.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor
            ),
            chatListCV.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor
            ),
            chatListCV.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}

extension ChatListViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        guard !searchText.isEmpty else {
            chatListCV.updateSnapshot()
            return
        }
        chatListCV.updateSnapshot(with: searchText)
    }
}

extension ChatListViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let data = chatListCV.diffableDataSource
            .snapshot(for: .main).items[indexPath.row]
        let chatRoomVC = ChatRoomViewController()
        chatRoomVC.title = data.chatroomName
        chatRoomVC.configureChatList(dataList: data.chatList)
        navigationController?.pushViewController(
            chatRoomVC,
            animated: true
        )
    }
}
