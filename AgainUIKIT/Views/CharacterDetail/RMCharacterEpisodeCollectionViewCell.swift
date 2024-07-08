//
//  RMCharacterEpisodesCollectionViewCell.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 04.07.2024.
//

import UIKit

class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterEpisodeCollectionViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let airDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let characters: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        setupCell()
        contentView.addSubview(containerView)
        containerView.addSubViews(name, airDate, characters)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        airDate.text = nil
        characters.text = nil
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            name.topAnchor.constraint(equalTo: containerView.topAnchor),
            name.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            name.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            airDate.topAnchor.constraint(equalTo: name.bottomAnchor),
            airDate.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            airDate.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            characters.topAnchor.constraint(equalTo: airDate.bottomAnchor),
            characters.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            characters.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            characters.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setupCell() {
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        viewModel.fetchEpisode(completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success((let episode, let characterNames)):
                    self?.name.text = episode.name
                    self?.airDate.text = episode.airDate
                    self?.characters.text = characterNames.joined(separator: ", ")
                case .failure(let error):
                    print(String(describing: error))
                    break
                }
            }
        })
    }
}
