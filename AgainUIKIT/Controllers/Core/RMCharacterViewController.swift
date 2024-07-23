//
//  RMCharacterViewController.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 22.06.2024.
//

import UIKit

/// RMCharacterViewController is a view controller that displays a list of characters.
final class RMCharacterViewController: UIViewController {

    private let characterListView = RMCharacterListView()
    private let searchListView = RMSearchView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Character"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        
        searchListView.isHidden = true
        
        view.addSubViews(characterListView, searchListView)
        setupLayout()
        characterListView.delegate = self
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            searchListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc
    private func search() {
        UIView.transition(with: view, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            self.characterListView.isHidden.toggle()
            self.searchListView.isHidden.toggle()
            self.title = self.characterListView.isHidden ? "Search" : "Character"
            self.searchListView.clear()
        }, completion: nil)
    }
}

extension RMCharacterViewController: RMCharacterListViewDelegate {
    /// When a character is selected, show the detail view controller
    func rmCharacterListView(_ character: RMCharacter) {
        let detailVC = RMCharacterDetailViewController(viewModel: RMCharacterDetailViewViewModel(character: character))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
