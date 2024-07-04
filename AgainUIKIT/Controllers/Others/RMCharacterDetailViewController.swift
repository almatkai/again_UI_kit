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
        setupCharacterDetailView()
        
        characterDetailView.collectionView?.dataSource = self
        characterDetailView.collectionView?.delegate = self
        
    }
    
    private func setupCharacterDetailView() {
        view.addSubview(characterDetailView)
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

extension RMCharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        case 2:
            return viewModel.character.episode?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.backgroundColor = .systemRed
        case 1:
            cell.backgroundColor = .systemBlue
        case 2:
            cell.backgroundColor = .systemPink
        default:
            cell.backgroundColor = .brown
        }
        return cell
    }
    
}
