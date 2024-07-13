//
//  RMEpisodeViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 12.07.2024.
//

import UIKit

protocol RMEpisodeViewDelegate: AnyObject {
    func initialEpisodesFetched()
}

final class RMEpisodeViewModel: NSObject {
    
    weak var delegate: RMEpisodeViewDelegate?
    
    var info: RMInfo? = nil
    var episodes: [RMEpisode] = []
    
    func fetchEpisodes() {
        RMService.shared.execute(
            .listEpisodesRequests,
            expecting: RMResponse<RMEpisode>.self,
            completion: { [weak self] res in
                guard let self = self else { return }
                switch res {
                case .success(let response):
                    self.info = response.info
                    self.episodes = response.results
                    DispatchQueue.main.async {
                        self.delegate?.initialEpisodesFetched()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }
}

extension RMEpisodeViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeViewCell.identifier, for: indexPath) as? RMEpisodeViewCell else {
            fatalError("Cell type mismatch")
        }
        cell.contentView.backgroundColor = .blue
        cell.configure(episodeName: episodes[indexPath.row].name ?? "Missing")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        return CGSize(width: bounds.width - 24, height: 0.2 * bounds.height)
    }
}

extension RMEpisodeViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        print(episodes.count)
    }
}
