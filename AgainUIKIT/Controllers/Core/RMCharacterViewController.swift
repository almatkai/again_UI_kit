//
//  RMCharacterViewController.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 22.06.2024.
//

import UIKit

final class RMCharacterViewController: UIViewController {

    private let characterListView = RMCharacterListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Character"
        view.addSubview(characterListView)
        setupLayout()
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
