//
//  RMCharacterCollectionViewViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 24.06.2024.
//

import Foundation

final class RMCharacterCollectionViewViewModel {
    
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageURL: URL?
    
    init(characterName: String, characterStatus: RMCharacterStatus, characterImageURL: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error  in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        })
        task.resume()
    }
}
