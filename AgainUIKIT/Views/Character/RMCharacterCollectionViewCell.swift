//
//  CharacterCollectionViewCell.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 24.06.2024.
//

import UIKit

/// Single cell for a character
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    static let cellIndetifier = "RMCharacterCollectionViewCell"
    
    /// Image view for character image
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// Label for character name
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    /// Label for character status
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = .systemFont(ofSize: 15, weight: .regular)
        statusLabel.textColor = .secondaryLabel
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubViews(imageView, nameLabel, statusLabel)
        addConstraints()
        
        setupLayer()
    }
        
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupLayer()
    }
    
    /// Style for cell
    private func setupLayer() {
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        contentView.layer.shadowOpacity = 0.4
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            
            /// Name label is above status label
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            /// Image view is above name label
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5)
        ])
    }
    
    
    /// Set up cell with view model
    /// - Parameter viewModel: Stores character data for cell
    func configure(with viewModel: RMCharacterCollectionViewViewModel) {
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        viewModel.fetchImage(completion: { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        })
    }
}
