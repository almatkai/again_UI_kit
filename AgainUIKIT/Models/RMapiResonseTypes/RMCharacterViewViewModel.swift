//
//  RMCharacterViewViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 24.06.2024.
//

import UIKit

protocol RMCharacterViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
}

final class RMCharacterViewViewModel: NSObject {
    
    public weak var delegate: RMCharacterViewViewModelDelegate?
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewViewModel(
                    characterName: character.name ?? "Missing",
                    characterStatus: character.status ?? .unknown,
                    characterImageURL: URL(string: character.image ?? "")
                )
                cellViewModels.append(viewModel)
            }
        }
    }
    private var cellViewModels: [RMCharacterCollectionViewViewModel] = []
    private var info: RMInfo = RMInfo(count: 0, pages: 0, next: nil, prev: nil)
    public func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests, expecting: RMResponse<RMCharacter>.self,
                                 completion: { [weak self]  result in
            switch result {
            case .success(let data):
                self?.characters = data.results
                self?.info = data.info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

extension RMCharacterViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIndetifier, for: indexPath) as? RMCharacterCollectionViewCell else { fatalError("Unsupported cell") }
        
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 36) / 2
        return CGSize(width: width, height: bounds.height * 0.3)
    }
}
