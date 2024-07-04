//
//  RMCharacterDetailViewViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 25.06.2024.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    var character: RMCharacter
    
    enum SectionTypes: CaseIterable{
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionTypes.allCases
    
    init(character: RMCharacter) {
        self.character = character
}
    
    public var name: String {
        character.name?.uppercased() ?? "Unknown"
    }
    
    public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = URL(string: character.image ?? "") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        RMImageLoader.shared.downalodImage(url, completion: completion)
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
