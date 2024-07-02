//
//  RMCharacterDetailViewViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 25.06.2024.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    var character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var name: String {
        character.name?.uppercased() ?? "Unknown"
    }
    
    public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = URL(string: character.image ?? "") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        RMImageLoader.shared.downalodImage(url, completion: completion)
    }
}
