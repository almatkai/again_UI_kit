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
    var episode: RMEpisode?
    var characters: [RMCharacter] = []
    
    init(episodeUrl: URL?) {
        self.episodeUrl = episodeUrl
    }
    
    func fetchEpisode(completion: @escaping (Result<(RMEpisode, [String]), Error>) -> Void) {
        guard let episodeUrl = episodeUrl else { return }
        guard let request = RMRequest(url: episodeUrl) else { return }
        var charactersNames: [String] = []
        let dispatchGroup = DispatchGroup()
        
        RMService.shared.execute(request, expecting: RMEpisode.self, completion: { result in
            switch result {
            case .success(let episode):
                episode.characters?.forEach {
                    dispatchGroup.enter()
                    self.fetchSingleCharacter(url: $0, completion: { result in
                        switch result {
                        case .success(let character):
                            self.characters.append(character)
                            charactersNames.append(character.name ?? "Missing")
                        case .failure(let error):
                            print(error)
                        }
                        dispatchGroup.leave()
                    })
                }
                self.episode = episode
                dispatchGroup.notify(queue: .main) {
                    completion(.success((episode, charactersNames)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    private func fetchSingleCharacter(url: String, completion: @escaping (Result<RMCharacter, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        guard let request = RMRequest(url: url) else { return }
        
        RMService.shared.execute(request, expecting: RMCharacter.self, completion: { result in
            completion(result)
        })
    }
}
