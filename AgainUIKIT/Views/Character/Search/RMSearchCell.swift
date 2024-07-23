//
//  File.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 23.07.2024.
//

import UIKit

class RMSearchCell: UICollectionViewCell {

    static let identifier = "RMSearchCell"

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private let id: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.image = UIImage(systemName: "person")
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerView)
        containerView.addSubViews(id, label)
        contentView.addSubview(image)
        contentView.backgroundColor = .secondarySystemBackground

        contentView.layer.cornerRadius = 12

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),

            id.topAnchor.constraint(equalTo: containerView.topAnchor),
            id.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            id.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            label.topAnchor.constraint(equalTo: id.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 10),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            image.widthAnchor.constraint(equalTo: image.heightAnchor)
        ])
    }

    func configure(with text: String, id: Int, image: UIImage) {
        self.label.text = text
        self.id.text = String(id)
        self.image.image = image
    }
}

