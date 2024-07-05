//
//  CharacterListView.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 24.06.2024.
//

import UIKit

/// Delegate for RMCharacterListView
protocol RMCharacterListViewDelegate: AnyObject {
    
    ///   Function that is called when character is selected
    /// - Parameters:
    ///   - rmCharacterListView:  Self
    ///   - character:  Selected character
    func rmCharacterListView(
        _ character: RMCharacter
    )
}

/// View that handles showing list of characters, loader, etc.
final class RMCharacterListView: UIView {
    
    public weak var delegate: RMCharacterListViewDelegate?
    
    private let viewModel = RMCharacterListViewViewModel()
    
    /// Spinner that is shown when loading characters
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 12, bottom: 20, right: 12)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        /// Register cells: RMCharacterCollectionViewCell, RMFooterLoadingCollectionReusableView
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIndetifier)
        
        /// Footer loading spinner
        collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(collectionView, spinner)
        
        addConstraints()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchFirstListOfCharacters()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

// MARK: - RMCharacterListViewViewModelDelegate

extension RMCharacterListView: RMCharacterListViewViewModelDelegate {
    
    /// Function that is called when additional characters are loaded
    func didLoadAdditionalCharacters(with newIndexpath: [IndexPath]) {
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: newIndexpath)
        }, completion: { success in
            if !success {
                print("Batch update failed")
            }
        })
    }
    
    /// Function that is called when character is selected
    /// and triggers rmCharacterListView so that the parent view controller can handle it
    func didSelectCharacter(_ character: RMCharacter) {
        delegate?.rmCharacterListView(character)
    }
    
    /// Disables spinner and shows collection view when initial characters are loaded
    func didLoadInitialCharacters() {
        self.spinner.stopAnimating()
        self.collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4, animations: {
            self.collectionView.alpha = 1
        })
    }
}
