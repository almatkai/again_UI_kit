//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 04.07.2024.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel {
    static let identifier = "RMCharacterPhotoCollectionViewCell"
    private let imageUrl: String
    public var image: Data? = nil
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        fetchImage(completion:{ result in
            switch result {
            case .success(let data):
                self.image = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = URL(string: imageUrl) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downalodImage(url, completion: completion)
    }
}
