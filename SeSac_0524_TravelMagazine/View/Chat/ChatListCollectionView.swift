//
//  ChatListCollectionView.swift
//  SeSac_0524_TravelMagazine
//
//  Created by gnksbm on 7/19/24.
//

import UIKit

final class ChatListCollectionView: UICollectionView {
    var diffableDataSource: DataSource!
    
    private let compotisionalLayout =
    UICollectionViewCompositionalLayout { _, env in
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        return NSCollectionLayoutSection.list(
            using: config,
            layoutEnvironment: env
        )
    }
    
    init() {
        super.init(
            frame: .zero,
            collectionViewLayout: compotisionalLayout
        )
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSnapshot() {
        var snapshot = Snapshot()
        let allSection = CollectionViewSection.allCases
        snapshot.appendSections(allSection)
        allSection.forEach { section in
            switch section {
            case .main:
                snapshot.appendItems(
                    mockChatList,
                    toSection: section
                )
            }
        }
        diffableDataSource.apply(snapshot)
    }
    
    func updateSnapshot(with searchTerm: String) {
        var snapshot = Snapshot()
        let allSection = CollectionViewSection.allCases
        snapshot.appendSections(allSection)
        allSection.forEach { section in
            switch section {
            case .main:
                snapshot.appendItems(
                    mockChatList.filter {
                        $0.chatroomName.contains(searchTerm)
                    },
                    toSection: section
                )
            }
        }
        diffableDataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        let cellRegistration = makeCellRegistration()
        diffableDataSource = DataSource(
            collectionView: self
        ) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }
        register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "UICollectionReusableView"
        )
    }
    
    private func makeCellRegistration() -> CellRegistration {
        CellRegistration { cell, indexPath, item in
            var config = UIListContentConfiguration.subtitleCell()
            let padding = CGFloat(16)
            let imageSize = CGFloat(60)
            config.image = item.mainImage
            config.directionalLayoutMargins = NSDirectionalEdgeInsets(
                top: padding,
                leading: padding,
                bottom: padding,
                trailing: padding
            )
            config.imageToTextPadding = 8
            config.imageProperties.cornerRadius = imageSize / 2
            config.imageProperties.reservedLayoutSize = CGSize(
                width: imageSize,
                height: imageSize
            )
            config.imageProperties.maximumSize = CGSize(
                width: imageSize,
                height: imageSize
            )
            config.text = item.chatroomName
            config.secondaryText = item.lastestMessage
            config.textToSecondaryTextVerticalPadding = 4
            cell.contentConfiguration = config
        }
    }
}

extension ChatListCollectionView {
    typealias DataSource =
    UICollectionViewDiffableDataSource<CollectionViewSection, ChatRoom>
    
    typealias Snapshot =
    NSDiffableDataSourceSnapshot<CollectionViewSection, ChatRoom>
    
    typealias CellRegistration =
    UICollectionView.CellRegistration<UICollectionViewCell, ChatRoom>
    
    typealias HeaderRegistraition =
    UICollectionView.SupplementaryRegistration<UICollectionViewCell>
    
    enum CollectionViewSection: CaseIterable {
        case main
    }
}
