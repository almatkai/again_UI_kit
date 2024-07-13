//
//  RMEpisodeViewCell.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 12.07.2024.
//

import UIKit

class RMEpisodeViewCell: UICollectionViewCell {

    static let identifier = "RMEpisodeViewCell"
    
    private let name: UILabel = {
        let label = UILabel()
        label.text = "Initial text"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(name)
        setupConstraints()
        contentView.backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            name.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            name.topAnchor.constraint(equalTo: contentView.topAnchor),
            name.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(episodeName: String) {
        name.text = episodeName
    }
}
