//
//  RMCharacterDetailView.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 25.06.2024.
//

import UIKit

class RMCharacterDetailView: UIView {

    private var viewModel: RMCharacterDetailViewViewModel
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = .systemFont(ofSize: 16, weight: .regular)
        statusLabel.textColor = .label
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
//    private let otherInfoLabel: UILabel = {
//        let otherInfoLabel = UILabel()
//        otherInfoLabel.font = .systemFont(ofSize: 15, weight: .regular)
//        otherInfoLabel.textColor = .label
//        otherInfoLabel.translatesAutoresizingMaskIntoConstraints = false
//        return otherInfoLabel
//    }()
    
    init(viewModel: RMCharacterDetailViewViewModel, frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
        configure()
        addSubViews(imageView, nameLabel, statusLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        let screenSize = UIScreen.main.bounds
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalToConstant: screenSize.width * 0.4),
            imageView.widthAnchor.constraint(equalToConstant: screenSize.width * 0.4),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 20),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            statusLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20),
            statusLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 20),
            
        ])
    }
    
    func configure() {
        self.nameLabel.text = self.viewModel.name
        self.statusLabel.text = self.viewModel.character.status?.text
        
        DispatchQueue.main.async {
            self.viewModel.fetchImage { result in
                switch result {
                case .success(let data):
                    self.imageView.image = UIImage(data: data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
