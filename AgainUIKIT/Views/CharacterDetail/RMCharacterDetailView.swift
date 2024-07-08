//
//  RMCharacterDetailView.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 25.06.2024.
//

import UIKit


class RMCharacterDetailView: UIView {

    private var viewModel: RMCharacterDetailViewViewModel
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    public var collectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Init
    
    init(viewModel: RMCharacterDetailViewViewModel, frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        if let collectionView = self.collectionView {
            addSubview(collectionView)
        }
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func addConstraints() {
        guard let collectionView = collectionView else { return }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(RMCharacterPhotoCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterPhotoCollectionViewCell.identifier)
        collectionView.register(RMCharacterInfoCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterInfoCollectionViewCell.identifier)
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        switch viewModel.sections[sectionIndex] {
        case .photo:
            return viewModel.createPhotoSection()
        case .information:
            return viewModel.createInformationSection()
        case .episodes:
            return viewModel.createEpisodesSection()
        }
    }
}



//private let imageView: UIImageView = {
//    let imageView = UIImageView()
//    imageView.contentMode = .scaleAspectFill
//    imageView.clipsToBounds = true
//    imageView.layer.cornerRadius = 10
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    return imageView
//}()
//
//private let nameLabel: UILabel = {
//    let nameLabel = UILabel()
//    nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
//    nameLabel.textColor = .label
//    nameLabel.translatesAutoresizingMaskIntoConstraints = false
//    nameLabel.numberOfLines = 3
//    nameLabel.backgroundColor = .green
//    return nameLabel
//}()
//
//private let statusLabel: UILabel = {
//    let statusLabel = UILabel()
//    statusLabel.font = .systemFont(ofSize: 16, weight: .regular)
//    statusLabel.textColor = .label
//    statusLabel.translatesAutoresizingMaskIntoConstraints = false
//    return statusLabel
//}()

// MARK: - Commented code with MY implementation
//        addSubview(containerView)
//        containerView.addSubViews(imageView, nameLabel, statusLabel)
//        addConstraints()


// MARK: - Commented code with the Constraints of MY Implementation
//    func addConstraints() {
//        let screenSize = UIScreen.main.bounds
//        NSLayoutConstraint.activate([
//
//            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
//            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
//            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
//
//            imageView.heightAnchor.constraint(equalToConstant: screenSize.width * 0.4),
//            imageView.widthAnchor.constraint(equalToConstant: screenSize.width * 0.4),
//            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
//            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
//
//            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
//            nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20),
//            nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
//
//            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
//            statusLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20),
//            statusLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
//
//        ])
//    }
