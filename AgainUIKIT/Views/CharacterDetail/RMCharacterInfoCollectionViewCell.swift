//
//  RMCharacterInfoCollectionViewCell.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 04.07.2024.
//

import UIKit

class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterInfoCollectionViewCell"
    
    private let titleContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let content: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellDesign()
        contentView.addSubViews(titleContainer, content)
        titleContainer.addSubview(title)
        setupConstrainsts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        content.text = nil
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            titleContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25),
            
            title.centerXAnchor.constraint(equalTo: titleContainer.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: titleContainer.centerYAnchor),
            
            content.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height * 0.1),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 4),
            content.bottomAnchor.constraint(equalTo: titleContainer.topAnchor, constant: 4),
        ])
    }
    
    private func setupCellDesign() {
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray.cgColor
    }
        
    func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        title.text = viewModel.type.tittle
        content.text = viewModel.displayContent
    }
}
