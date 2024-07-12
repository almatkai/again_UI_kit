//
//  RMEpisodeViewController.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 22.06.2024.
//

import UIKit

final class RMEpisodeViewController: UIViewController {
    
    private let episodeView = RMEpisodeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        
        view.addSubview(episodeView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            episodeView.leftAnchor.constraint(equalTo: view.leftAnchor),
            episodeView.rightAnchor.constraint(equalTo: view.rightAnchor),
            episodeView.topAnchor.constraint(equalTo: view.topAnchor),
            episodeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}
