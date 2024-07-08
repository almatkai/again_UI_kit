//
//  RMEpisodeViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 08.07.2024.
//

import UIKit

final class RMEpisodeViewModel {
    let epidsode: RMEpisode
    let characters: [RMCharacter]
    
    init(epidsode: RMEpisode, characters: [RMCharacter]) {
        self.epidsode = epidsode
        self.characters = characters
        setupSections()
    }
    
    var sections: [Section] = []
    
    enum Section {
        case episode(epidsode: RMEpisode)
        case character(characters: [RMCharacter])
    }
    
    private func setupSections() {
        sections.append(.episode(epidsode: epidsode))
        sections.append(.character(characters: characters))
    }
    
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
                                leading: 7,
                                bottom: 3,
                                trailing: 7
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
            subitems: [item, item]
        )
        
        group.contentInsets = NSDirectionalEdgeInsets(
                                top: 0,
                                leading: 3,
                                bottom: 0,
                                trailing: 3
                                )
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }

}
