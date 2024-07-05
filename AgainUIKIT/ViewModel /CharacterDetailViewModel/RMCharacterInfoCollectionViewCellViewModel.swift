//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 04.07.2024.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel {
    static let identifier = "RMCharacterInfoCollectionViewCell"
    var text: String
    
    init(text: String) {
        self.text = text
    }

}
