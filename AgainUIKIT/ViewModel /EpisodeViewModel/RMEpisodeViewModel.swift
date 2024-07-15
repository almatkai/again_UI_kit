//
//  RMEpisodeViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 12.07.2024.
//

import UIKit

protocol RMEpisodeViewDelegate: AnyObject {
    func initialEpisodesFetched()
    func didLoadAdditionalCharacters(with newIndexpath: [IndexPath])
}

final class RMEpisodeViewModel: NSObject {
    
    weak var delegate: RMEpisodeViewDelegate?
    
    var info: RMInfo? = nil
    var episodeViewModels: [RMEpisodeViewCellViewModel] = []
    var loadingMore = false
    
    func fetchEpisodes() {
        RMService.shared.execute(.listEpisodesRequests, expecting: RMResponse<RMEpisode>.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.info = response.info
                let episodes = response.results
                self?.fetchCharactersForEpisodes(episodes)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchCharactersForEpisodes(_ episodes: [RMEpisode]) {
        let dispatchGroup = DispatchGroup()
        var episodeViewModels: [RMEpisodeViewCellViewModel] = []

        for episode in episodes {
            guard let characterURLs = episode.characters else { continue }
            var characters: [RMCharacter] = []

            for urlString in characterURLs {
                guard let url = URL(string: urlString) else { continue }
                dispatchGroup.enter()
                fetchCharacters(url: url) { result in
                    defer { dispatchGroup.leave() }
                    switch result {
                    case .success(let character):
                        characters.append(character)
                    case .failure(let error):
                        print(error)
                    }
                }
            }

            dispatchGroup.notify(queue: .main) {
                let viewModel = RMEpisodeViewCellViewModel(episode: episode, characters: characters)
                episodeViewModels.append(viewModel)
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.episodeViewModels = episodeViewModels
            self?.delegate?.initialEpisodesFetched()
        }
    }
    
    private func fetchCharacters(url: URL, completion: @escaping (Result<RMCharacter, Error>) -> Void) {
        guard let rmRequest = RMRequest(url: url) else { return }
        RMService.shared.execute(rmRequest, expecting: RMCharacter.self, completion: {
            completion($0)
        })
    }
}

extension RMEpisodeViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        episodeViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeViewCell.identifier, for: indexPath) as? RMEpisodeViewCell else {
            fatalError("Cell type mismatch")
        }
        cell.configure(viewModel: episodeViewModels[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        return CGSize(width: bounds.width - 24, height: 0.2 * bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier, for: indexPath) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Footer type mismatch")
        }
        if info?.next != nil {
            footer.startAnimating()
        }
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension RMEpisodeViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let totalLength = (episodeViewModels.count - 2) * 150
        if Int(offset) - totalLength > 0, !loadingMore, info?.next != nil {
            loadingMore = true
            fetchEpisodes(episodeURL: URL(string: info!.next!))
        }
    }
}
