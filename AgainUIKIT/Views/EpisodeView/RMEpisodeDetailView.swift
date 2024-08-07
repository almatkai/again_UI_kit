//
//  RMEpisodeDetailView.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 08.07.2024.
//

import UIKit

class RMEpisodeDetailView: UIView {
    
    private let viewModel: RMEpisodeViewModel
    public var collectionView: UICollectionView?
    
    init(viewModel: RMEpisodeViewModel, frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        if let collectionView = self.collectionView {
            addSubview(collectionView)
        }
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
private func createCollectionView() -> UICollectionView {
    let layout = UICollectionViewCompositionalLayout { index, _ in
        self.createSection(for: index)
    }
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    collectionView.register(RMEpisodeDescriptionCollectionViewCell.self, forCellWithReuseIdentifier: RMEpisodeDescriptionCollectionViewCell.identifier)
    collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIndetifier)
    collectionView.register(RMHeaderCollectionReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: RMHeaderCollectionReusableView.identifier)
    return collectionView
}
    
    private func setupConstraints() {
        guard let collectionView = collectionView else { return }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        switch viewModel.sections[sectionIndex] {
        case .episode:
            return viewModel.createEpisodeSection()
        case .character:
            return viewModel.createCharacterSection()
        }
    }
}
