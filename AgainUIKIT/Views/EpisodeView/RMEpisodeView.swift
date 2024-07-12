//
//  RMEpisodeView.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 12.07.2024.
//

import UIKit

class RMEpisodeView: UIView {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMEpisodeViewCell.self, forCellWithReuseIdentifier: RMEpisodeViewCell.identifier)
//        collectionView.isHidden = true
//        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
//    private let spinner: UIActivityIndicatorView = {
//        let spinner = UIActivityIndicatorView()
//        spinner.hidesWhenStopped = true
//        spinner.startAnimating()
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        return spinner
//    }()
    
    private let viewModel = RMEpisodeViewModel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        viewModel.fetchEpisodes()
        setupCollectionView()
        addSubViews(collectionView)
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
            
//            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
//            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
//            spinner.widthAnchor.constraint(equalToConstant: 100),
//            spinner.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
    
}
