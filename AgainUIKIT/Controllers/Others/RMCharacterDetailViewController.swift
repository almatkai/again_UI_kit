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
        
        setupCharacterDetailView()
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
}
