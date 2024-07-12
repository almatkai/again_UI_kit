//
//  RMEpisodeViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 12.07.2024.
//

import UIKit

final class RMEpisodeViewModel: NSObject {
    
    var info: RMInfo? = nil
    var episodes: [RMEpisode] = []
    
    func fetchEpisodes() {
        RMService.shared.execute(.listEpisodesRequests, expecting: RMResponse<RMEpisode>.self, completion: { [weak self] res in
            switch res {
            case .success(let response):
                self?.info = response.info
                self?.episodes = response.results
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

extension RMEpisodeViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeViewCell.identifier, for: indexPath)
        cell.contentView.backgroundColor = .blue
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        return CGSize(width: bounds.width - 24, height: 0.2 * bounds.height)
    }
}
