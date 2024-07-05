//
//  RMCharacterDetailViewController.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 25.06.2024.
//

import UIKit

class RMCharacterDetailViewController: UIViewController {
    
    private let viewModel: RMCharacterDetailViewViewModel
    
    private lazy var characterDetailView: RMCharacterDetailView = {
        let view = RMCharacterDetailView(viewModel: self.viewModel, frame: self.view.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        view.addSubview(characterDetailView)
        addConstraints()
        
        characterDetailView.collectionView?.dataSource = self
        characterDetailView.collectionView?.delegate = self
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            characterDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc 
    private func didTapShare() {
        print("Share tapped")
    }
}

// MARK: - CollectionView

extension RMCharacterDetailViewController: 
    UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .photo:
            return 1
        case .information(let info):
            return info.count
        case .episodes(let episodes):
            return episodes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch viewModel.sections[indexPath.section] {
        case .photo(let viewModel):
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCollectionViewCell.identifier, for: indexPath) as? RMCharacterPhotoCollectionViewCell else {
                fatalError("Unsupported cell")
            }
            
            cell.configure(with: RMCharacterPhotoCollectionViewCellViewModel(imageUrl: self.viewModel.character.image ?? ""))
            return cell
        case .information(let viewModels):
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInfoCollectionViewCell.identifier, for: indexPath) as? RMCharacterInfoCollectionViewCell else {
                fatalError("Unsupported cell")
            }
            
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .episodes(let viewModels):
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.identifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
                fatalError("Unsupported cell")
            }
            
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
}
