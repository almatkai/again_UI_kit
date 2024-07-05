//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 04.07.2024.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCellViewModel {
    static let identifier = "RMCharacterEpisodeCollectionViewCell"
    
    private var episodeUrl: URL?
    public var episode: RMEpisode? = nil
    
    init(episodeUrl: URL?) {
        self.episodeUrl = episodeUrl
    }
    
    func fetchEpisodeData(completion: @escaping (RMEpisode?) -> Void) {
        guard let url = episodeUrl else {
            print("Episode URL is wrong")
            completion(nil)
            return
        }
        guard let request = RMRequest(url: url) else {
            print("Request URL is wrong")
            completion(nil)
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self, completion: { [weak self] result in
            switch result {
            case .success(let episode):
                self?.episode = episode
                completion(episode)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        })
    }
}
