//
//  RMEpisodeView.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 12.07.2024.
//

import UIKit

protocol RMEpisodeViewDelegate: AnyObject {
    func didTappedEpisode(viewModel: RMEpisodeViewCellViewModel)
}

class RMEpisodeView: UIView, RMEpisodeViewDelegate {
    
    weak var delegate: RMEpisodeViewDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        ///  Register Cell
        collectionView.register(RMEpisodeViewCell.self, forCellWithReuseIdentifier: RMEpisodeViewCell.identifier)
        
        /// Footer loading spinner
        collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let viewModel = RMEpisodeViewModel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupCollectionView()
        addSubViews(collectionView, spinner)
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        
        viewModel.delegate = self
    }
    
}

extension RMEpisodeView: RMEpisodeViewModelDelegate {
    func didTappedEpisode(viewModel: RMEpisodeViewCellViewModel) {
        delegate?.didTappedEpisode(viewModel: viewModel)
    }
    
    
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
    
    func initialEpisodesFetched() {
        spinner.stopAnimating()
        collectionView.reloadData()
        collectionView.isHidden = false
        collectionView.transform = CGAffineTransform(
            translationX: 0,
            y: self.bounds.height / 2).scaledBy(x: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.4, delay: 0.05, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.5, options: [], animations: {
            self.collectionView.transform = .identity
            self.collectionView.alpha = 1
        })
    }
}
