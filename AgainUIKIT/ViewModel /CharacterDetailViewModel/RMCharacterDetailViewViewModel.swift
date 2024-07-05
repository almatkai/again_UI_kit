//
//  RMCharacterDetailViewViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 25.06.2024.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    var character: RMCharacter
    
    enum SectionTypes {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModel: [RMCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModel: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    
    public var sections: [SectionTypes] = []
    
    init(character: RMCharacter) {
        self.character = character
        setupSections()
    }
    
    public var name: String {
        character.name?.uppercased() ?? "Unknown"
    }
    
    private func setupSections() {
        sections.append(.photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel(imageUrl: character.image ?? "")))
        
        var infoViewModel: [RMCharacterInfoCollectionViewCellViewModel] = []
        infoViewModel.append(RMCharacterInfoCollectionViewCellViewModel())
        infoViewModel.append(RMCharacterInfoCollectionViewCellViewModel())
        infoViewModel.append(RMCharacterInfoCollectionViewCellViewModel())
        infoViewModel.append(RMCharacterInfoCollectionViewCellViewModel())
        sections.append(.information(viewModel: infoViewModel))
        
        var episodesViewModel: [RMCharacterEpisodeCollectionViewCellViewModel] = []
        if let episodes = character.episode {
            episodes.forEach{ _ in
                episodesViewModel.append(RMCharacterEpisodeCollectionViewCellViewModel())
            }
        }
        sections.append(.episodes(viewModel: episodesViewModel))
    }
    
    func createPhotoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
                                top: 10,
                                leading: 10,
                                bottom: 3,
                                trailing: 10
                            )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(1)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createInformationSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )

        item.contentInsets = NSDirectionalEdgeInsets(
            top: 3,
            leading: 3,
            bottom: 3,
            trailing: 3
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(120)
            ),
            subitems: [item, item]
        )
        group.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 7,
                bottom: 0,
                trailing: 7
            )
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }

    
    func createEpisodesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
                                top: 3,
                                leading: 10,
                                bottom: 3,
                                trailing: 10
                            )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
}
