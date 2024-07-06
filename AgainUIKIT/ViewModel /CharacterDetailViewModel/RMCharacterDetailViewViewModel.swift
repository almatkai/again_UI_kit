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
        
        sections.append(.information(viewModel: setupInfoVM()))
        
        sections.append(.episodes(viewModel: setupEpisodesVM()))
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

    private func setupInfoVM() -> [RMCharacterInfoCollectionViewCellViewModel] {
        var infoViewModel: [RMCharacterInfoCollectionViewCellViewModel] = []
        
        if let name = character.name {
            infoViewModel.append(RMCharacterInfoCollectionViewCellViewModel(text: name))
        }

        if let status = character.status?.text {
            infoViewModel.append(RMCharacterInfoCollectionViewCellViewModel(text: status))
        }

        let typeSpecies = "\(character.type ?? "") \(character.species ?? "")"
        if !typeSpecies.trimmingCharacters(in: .whitespaces).isEmpty {
            infoViewModel.append(RMCharacterInfoCollectionViewCellViewModel(text: typeSpecies))
        }

        if let gender = character.gender?.rawValue {
            infoViewModel.append(RMCharacterInfoCollectionViewCellViewModel(text: gender))
        }

        if let origin = character.origin?.name, origin != "unknown"{
            infoViewModel.append(RMCharacterInfoCollectionViewCellViewModel(text: origin))
        }

        if let location = character.location?.name {
            infoViewModel.append(RMCharacterInfoCollectionViewCellViewModel(text: location))
        }
        
        return infoViewModel
    }
    
    private func setupEpisodesVM() -> [RMCharacterEpisodeCollectionViewCellViewModel] {
        var episodesViewModel: [RMCharacterEpisodeCollectionViewCellViewModel] = []
        
        for episode in character.episode ?? [] {
            guard let url = URL(string: episode) else { break }
            episodesViewModel.append(RMCharacterEpisodeCollectionViewCellViewModel(episodeUrl: url))
        }
        
        return episodesViewModel
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
