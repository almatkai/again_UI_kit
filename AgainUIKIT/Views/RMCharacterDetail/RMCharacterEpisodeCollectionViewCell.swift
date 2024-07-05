//
//  RMCharacterEpisodesCollectionViewCell.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 04.07.2024.
//

import UIKit

class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterEpisodeCollectionViewCell"
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupConstrainsts() {
        
    }
    
    func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        
    }
}
