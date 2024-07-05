//
//  RMCharacterEpisodesCollectionViewCell.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 04.07.2024.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterEpisodeCollectionViewCell"
    
    private let episodeName: UILabel =  {
        let episodeName = UILabel()
        episodeName.translatesAutoresizingMaskIntoConstraints = false
        episodeName.numberOfLines = 3
        episodeName.textAlignment = .center
        return episodeName
    }()
    
    private let airDate: UILabel =  {
        let airDate = UILabel()
        airDate.translatesAutoresizingMaskIntoConstraints = false
        airDate.numberOfLines = 3
        return airDate
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        setupCell()
        addSubViews(episodeName, airDate)
        setupConstrainsts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        episodeName.text = nil
        airDate.text = nil
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            episodeName.centerXAnchor.constraint(equalTo: centerXAnchor),
            episodeName.centerYAnchor.constraint(equalTo: centerYAnchor),
            episodeName.topAnchor.constraint(equalTo: topAnchor),
            episodeName.leftAnchor.constraint(equalTo: leftAnchor),
            episodeName.leftAnchor.constraint(equalTo: leftAnchor),
            
            airDate.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            airDate.leftAnchor.constraint(equalTo: rightAnchor),
            airDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
    }
    
    private func setupCell() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        viewModel.fetchEpisodeData { [weak self] episode in
            DispatchQueue.main.async {
                self?.episodeName.text = episode?.name
                self?.airDate.text = episode?.airDate
            }
        }
    }
}
