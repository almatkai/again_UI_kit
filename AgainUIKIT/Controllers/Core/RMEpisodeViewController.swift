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
        episodeView.viewModel.fetchEpisodes()
        view.addSubview(episodeView)
        setupConstraints()
        
        episodeView.delegate = self
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

extension RMEpisodeViewController:  RMEpisodeViewDelegate {
    func didTappedEpisode(viewModel: RMEpisodeViewCellViewModel) {
        let detailVC = RMEpisodeDetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
