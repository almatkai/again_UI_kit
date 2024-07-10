//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 04.07.2024.
//

import Foundation

final class RMCharacterEpisodeCollectionViewCellViewModel {
    static let identifier = "RMCharacterEpisodeCollectionViewCell"
    
    private let episodeUrl: URL?
    public private(set) var episode: RMEpisode?
    public private(set) var characters: [RMCharacter] = []
    
    init(episodeUrl: URL?) {
        self.episodeUrl = episodeUrl
    }
    
    func fetchEpisode(completion: @escaping (Result<(RMEpisode, [String]), Error>) -> Void) {
        guard let episodeUrl = episodeUrl,
              let request = RMRequest(url: episodeUrl) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let episode):
                self.episode = episode
                let characterUrls = episode.characters ?? []
                let semaphore = DispatchSemaphore(value: 0)
                var fetchedCharacters: [RMCharacter] = []
                var fetchErrors: [Error] = []
                DispatchQueue.global(qos: .userInitiated).async {
                    for charUrl in characterUrls {
                        self.fetchSingleCharacter(url: charUrl) { result in
                            switch result {
                            case .success(let character):
                                fetchedCharacters.append(character)
                            case .failure(let error):
                                fetchErrors.append(error)
                            }
                            semaphore.signal()
                        }
                        semaphore.wait()
                    }
                    DispatchQueue.main.async {
                        self.characters = fetchedCharacters
                        let characterNames = fetchedCharacters.compactMap { $0.name }
                        
                        if !fetchErrors.isEmpty {
                            print("Some character fetches failed: \(fetchErrors)")
                        }
                        
                        completion(.success((episode, characterNames)))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchSingleCharacter(url: String, completion: @escaping (Result<RMCharacter, Error>) -> Void) {
        guard let url = URL(string: url),
              let request = RMRequest(url: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        RMService.shared.execute(request, expecting: RMCharacter.self, completion: completion)
    }
}
