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
            print("IMAGE URL IS NIL")
            completion(.failure(URLError(.badURL)))
            return
        }
        print("""
            Fetching image from: \(url)
            """)
        let request = URLRequest(url: url)
        RMImageLoader.shared.downalodImage(url, completion: completion)
    }
}
