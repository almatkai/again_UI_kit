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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Character"
        view.addSubview(characterListView)
        setupLayout()
        characterListView.delegate = self
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
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
