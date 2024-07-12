//
//  RMEpisodeDetailViewController.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 08.07.2024.
//

import UIKit

class RMEpisodeDetailViewController: UIViewController {
    
    private let viewModel: RMEpisodeViewCellViewModel
    
    private lazy var episodeDetailView: RMEpisodeDetailView = {
        let view = RMEpisodeDetailView(viewModel: self.viewModel, frame: view.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: RMEpisodeViewCellViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(episodeDetailView)
        addConstraints()
        
        episodeDetailView.collectionView?.dataSource = self
        episodeDetailView.collectionView?.delegate = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            episodeDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            episodeDetailView.leftAnchor.constraint(equalTo: view.leftAnchor),
            episodeDetailView.rightAnchor.constraint(equalTo: view.rightAnchor),
            episodeDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension RMEpisodeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .episode:
            return 1
        case .character:
            return viewModel.characters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.sections[indexPath.section] {
        case .episode(let episode):
            break
        case .character(let characters):
            let character = characters[indexPath.row]
            let characterDetailViewModel = RMCharacterDetailViewViewModel(character: character)
            let characterDetailViewController = RMCharacterDetailViewController(viewModel: characterDetailViewModel)
            navigationController?.pushViewController(characterDetailViewController, animated: true)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .episode(let episode):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeDescriptionCollectionViewCell.identifier, for: indexPath) as? RMEpisodeDescriptionCollectionViewCell else {
                fatalError("Unsupported cell")
            }
            cell.configure(with: episode)
            return cell
        case .character(let characters):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIndetifier, for: indexPath) as? RMCharacterCollectionViewCell else {
                fatalError("Unsupported cell")
            }
            let viewModel = RMCharacterCollectionViewViewModel(
                characterName: characters[indexPath.row].name ?? "Missing",
                characterStatus: characters[indexPath.row].status ?? .unknown,
                characterImageURL: URL(string: characters[indexPath.row].image ?? ""))
            
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RMHeaderCollectionReusableView.identifier,
            for: indexPath
        ) as! RMHeaderCollectionReusableView
        
        let section = viewModel.sections[indexPath.section]
        switch section {
        case .episode:
            header.setLabelText(text: "Episode Info")
        case .character:
            header.setLabelText(text: "Characters")
        }
        
        return header
    }
    
}
