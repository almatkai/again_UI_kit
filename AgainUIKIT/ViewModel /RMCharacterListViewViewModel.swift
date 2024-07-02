//
//  RMCharacterViewViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 24.06.2024.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadAdditionalCharacters(with newIndexpath: [IndexPath])
    func didSelectCharacter(_ character: RMCharacter)
}

///  View model to handle character list view logic
final class RMCharacterListViewViewModel: NSObject {
    
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var isPaginating = false
    
    private var characters: [RMCharacter] = [] {
        didSet {
            let index = cellViewModels.count
            for i in index..<characters.count {
                let viewModel = RMCharacterCollectionViewViewModel(
                    characterName: characters[i].name ?? "Missing",
                    characterStatus: characters[i].status ?? .unknown,
                    characterImageURL: URL(string: characters[i].image ?? "")
                )
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [RMCharacterCollectionViewViewModel] = []
    private var apiInfo: RMInfo? = nil
    
    
    /// Fetches first list of characters (20)
    public func fetchFirstListOfCharacters() {
        RMService.shared.execute(.listCharactersRequests, expecting: RMResponse<RMCharacter>.self,
                                 completion: { [weak self]  result in
            switch result {
            case .success(let data):
                self?.characters = data.results
                self?.apiInfo = data.info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    /// Paginate if additional characters are needed
    private func fetchAdditionalCharacters(url: URL) {
        guard !isPaginating else { return }
        isPaginating = true
        guard let request = RMRequest(url: url) else {
            isPaginating = false
            print("RMCharacterListViewViewModel: Invalid URL")
            return
        }
        
        RMService.shared.execute(request, expecting: RMResponse<RMCharacter>.self,
                                 completion: { [weak self]  result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let data):
                strongSelf.characters.append(contentsOf: data.results)
                strongSelf.apiInfo = data.info
                DispatchQueue.main.async {
                    let startIndex = strongSelf.characters.count - data.results.count
                    let indexPaths = (startIndex..<strongSelf.characters.count).map({ IndexPath(row: $0, section: 0) })
                    strongSelf.delegate?.didLoadAdditionalCharacters(with: indexPaths)
                    strongSelf.isPaginating = false
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return true // apiInfo?.next != nil
    }
}

// MARK: - CollectionView

extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            return cellViewModels.count
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 36) / 2
        return CGSize(width: width, height: bounds.height * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCharacter(characters[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else { return .zero }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    /// Footer
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIndetifier,
            for: indexPath) as? RMCharacterCollectionViewCell
        else { fatalError("Unsupported cell") }
        
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            fatalError("Unsupported")
        }
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
            for: indexPath) as? RMFooterLoadingCollectionReusableView else { fatalError("Unsupported") }
        
        footer.startAnimating()
        
        return footer
    }
}

extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard shouldShowLoadMoreIndicator,
              !cellViewModels.isEmpty,
              !isPaginating,
              let nextUrlString = self.apiInfo?.next,
              let url = URL(string: nextUrlString) else { return }
        
        let offSet = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollHeight = scrollView.frame.size.height
        
        if offSet > totalContentHeight - totalScrollHeight - 10, offSet != 0 {
            fetchAdditionalCharacters(url: url)
        }
    }
}
