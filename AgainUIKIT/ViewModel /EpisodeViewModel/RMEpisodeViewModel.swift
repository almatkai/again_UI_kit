//
//  RMEpisodeViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 12.07.2024.
//

import UIKit

protocol RMEpisodeViewModelDelegate: AnyObject {
    func initialEpisodesFetched()
    func didLoadAdditionalCharacters(with newIndexpath: [IndexPath])
    func didTappedEpisode(viewModel: RMEpisodeViewCellViewModel)
}

final class RMEpisodeViewModel: NSObject {
    
    weak var delegate: RMEpisodeViewModelDelegate?
    
    var info: RMInfo? = nil
    var episodeViewModels: [RMEpisodeViewCellViewModel] = []
    var loadingMore = false
    
    func fetchEpisodes(episodesURL: URL? = nil) {
        var rmRequest: RMRequest = .listEpisodesRequests
        if let episodesURL = episodesURL {
            guard let request = RMRequest(url: episodesURL) else { return }
            rmRequest = request
        }
        RMService.shared.execute(rmRequest, expecting: RMResponse<RMEpisode>.self, completion: {
            [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.info = response.info
                self.setupEpisodeViewModel(episodes: response.results) {
                    DispatchQueue.main.async {
                        if episodesURL != nil {
                            let indexPath = (self.episodeViewModels.count - response.results.count ..< self.episodeViewModels.count).map { IndexPath(row: $0, section: 0)}
                            self.delegate?.didLoadAdditionalCharacters(
                                with: indexPath)
                        } else {
                            self.delegate?.initialEpisodesFetched()
                        }
                        self.loadingMore = false
                    }
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func setupEpisodeViewModel(episodes: [RMEpisode], completion: @escaping () -> Void) {
        var indexPaths = [IndexPath]()
        let startCount = self.episodeViewModels.count
        let group = DispatchGroup()

        episodes.forEach { episode in
            guard let characterURLs = episode.characters else { return }

            self.episodeViewModels.append(RMEpisodeViewCellViewModel(episode: episode))
            let indexPath = IndexPath(row: startCount + indexPaths.count, section: 0)
            indexPaths.append(indexPath)
            
        }

        group.notify(queue: .main) {
            completion()
        }
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
        info?.next != nil ? footer.startAnimating() : footer.stopAnimating()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: info?.next != nil ? 100 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTappedEpisode(viewModel: episodeViewModels[indexPath.row])
    }
}

extension RMEpisodeViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let totalLength = (episodeViewModels.count - 1) * 150
        if Int(offset) - totalLength > 0, !loadingMore, info?.next != nil {
            loadingMore = true
            guard let url = URL(string: info!.next!) else {
                loadingMore = false
                return
            }
            fetchEpisodes(episodesURL: url)
        }
    }
}
