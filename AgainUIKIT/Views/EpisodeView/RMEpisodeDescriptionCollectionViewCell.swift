//
//  RMEpisodeDescriptionCollectionViewCell.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 08.07.2024.
//

import UIKit

class RMEpisodeDescriptionCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMEpisodeDescriptionCollectionViewCell"
    
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
    
    private let episode: UILabel = {
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
        containerView.addSubViews(name, airDate, episode)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        airDate.text = nil
        episode.text = nil
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            name.topAnchor.constraint(equalTo: containerView.topAnchor),
            name.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            name.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            airDate.topAnchor.constraint(equalTo: name.bottomAnchor),
            airDate.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            airDate.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            episode.topAnchor.constraint(equalTo: airDate.bottomAnchor),
            episode.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            episode.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            episode.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func setupCell() {
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        contentView.layer.shadowOpacity = 0.4
    }
    
    func configure(with episode: RMEpisode) {
        name.text = episode.name
        if let airDate = episode.airDate {
            
            self.airDate.text = "Relased: \(airDate)"
        }
        self.episode.text = episode.episode
    }
}
