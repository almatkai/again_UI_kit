//
//  RMEpisodeViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 08.07.2024.
//

import UIKit

final class RMEpisodeViewCellViewModel {
    let episode: RMEpisode
    let characters: [RMCharacter]

    // MARK: - Init

    init(episode: RMEpisode, characters: [RMCharacter]) {
        self.episode = episode
        self.characters = characters
        setupSections()
    }
    
    var sections: [Section] = []
    
    /// Two sections: episode and characters
    /// Episode section Stores episode information: name, air date, episode code, ...
    /// Characters section stores all characters that are in this episode
    enum Section {
        case episode(episode: RMEpisode)
        case character(characters: [RMCharacter])
    }
    
    private func setupSections() {
        sections.append(.episode(episode: episode))
        sections.append(.character(characters: characters))
    }
    
    /// Returns a collection layout section for episode
    ///  - Returns: NSCollectionLayoutSection
    func createEpisodeSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.4)
            ),
            subitems: [item]
        )
        group.contentInsets = NSDirectionalEdgeInsets(
                                top: 7,
                                leading: 10,
                                bottom: 3,
                                trailing: 10
                            )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createCharacterSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )

        item.contentInsets = NSDirectionalEdgeInsets(
                                top: 7,
                                leading: 7,
                                bottom: 7,
                                trailing: 7
                                )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.64)
            ),
            /// 2 rows of Characters
            subitems: [item, item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        /// Header part of the section
        let header  = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(100)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.contentInsets = NSDirectionalEdgeInsets(
                                top: 40,
                                leading: 16,
                                bottom: 7,
                                trailing: 7
                                )
        
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(
                                top: 0,
                                leading: 3,
                                bottom: 0,
                                trailing: 3
                                )
        
        return section
    }

}
