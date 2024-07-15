//
//  RMEpisodeViewCell.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 12.07.2024.
//

import UIKit

class RMEpisodeViewCell: UICollectionViewCell {

    static let identifier = "RMEpisodeViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.text = "Initial text"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let characters: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .white
        label.numberOfLines = 5
        label.textColor = .secondaryLabel
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerView)
        containerView.addSubViews(name, characters)
        setupConstraints()
        contentView.backgroundColor = .tertiarySystemBackground
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        characters.text = nil
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            name.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            name.topAnchor.constraint(equalTo: containerView.topAnchor),
            name.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            characters.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            characters.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            characters.topAnchor.constraint(equalTo: name.bottomAnchor),
        ])
    }
    
    private func setupCell() {
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    func configure(viewModel: RMEpisodeViewCellViewModel) {
        name.text = viewModel.episode.name
        characters.text = viewModel.characters.compactMap({ $0.name }).joined(separator: ", ")
    }
}
