//
//  SearchView.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 20.07.2024.
//

import UIKit

final class RMSearchView: UIView {
    
    private var textFieldAndFilterContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textFieldBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.font = .systemFont(ofSize: 22)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let filterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "line.horizontal.3.decrease.circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var text = ""
    
    private var characters: [RMCharacter] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenWidth - 20, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMSearchCell.self, forCellWithReuseIdentifier: RMSearchCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = 12
        return collectionView
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubViews(textFieldAndFilterContainer, collectionView)
        textFieldAndFilterContainer.addSubViews(textFieldBackgroundView, filterImageView)
        textFieldBackgroundView.addSubview(textField)
        setupConstraints()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textFieldAndFilterContainer.topAnchor.constraint(equalTo: topAnchor),
            textFieldAndFilterContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldAndFilterContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            textFieldAndFilterContainer.heightAnchor.constraint(equalToConstant: 50), // Add this line

            textFieldBackgroundView.topAnchor.constraint(equalTo: textFieldAndFilterContainer.topAnchor, constant: 10),
            textFieldBackgroundView.leadingAnchor.constraint(equalTo: textFieldAndFilterContainer.leadingAnchor, constant: 10),
            textFieldBackgroundView.trailingAnchor.constraint(equalTo: filterImageView.leadingAnchor, constant: -10),
            textFieldBackgroundView.heightAnchor.constraint(equalToConstant: 40), // Add this line

            filterImageView.widthAnchor.constraint(equalToConstant: 30),
            filterImageView.heightAnchor.constraint(equalToConstant: 30),
            filterImageView.leadingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor),
            filterImageView.trailingAnchor.constraint(equalTo: textFieldAndFilterContainer.trailingAnchor, constant: -10),
            filterImageView.centerYAnchor.constraint(equalTo: textFieldAndFilterContainer.centerYAnchor), // Add this line

            textField.topAnchor.constraint(equalTo: textFieldBackgroundView.topAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor, constant: -10),
            textField.bottomAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor, constant: -10),

            collectionView.topAnchor.constraint(equalTo: textFieldAndFilterContainer.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    
    func clear() {
        textField.text = nil
    }
}

extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMSearchCell.identifier, for: indexPath) as? RMSearchCell else {
            fatalError("Cell type mismatch")
        }
        guard let imageURLString = characters[indexPath.row].image else { return cell }
        guard let imageURL = URL(string: imageURLString) else { return cell }
        
        RMImageLoader.shared.downalodImage(imageURL) {
            switch $0 {
            case .success(let data ):
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    cell.configure(
                        with: self.characters[indexPath.row].name ?? "Missing",
                        id: self.characters[indexPath.row].id ?? -1,
                        image: image)
                }
            case .failure(let error):
                print("Error loading image: \(imageURLString)")
                print(error)
            }
            
        }
        return cell
    }
}

extension RMSearchView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text == "" {
            DispatchQueue.main.async {
                self.characters = []
                self.collectionView.reloadData()
            }
            return
        }
        let rmRequest = RMRequest(
            endpoint: .character,
            queryParameters: [URLQueryItem(name: "name", value: text)]
        )
        
        RMService.shared.execute(rmRequest, expecting: RMResponse<RMCharacter>.self, completion: { [weak self] res in
            switch res {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.characters = response.results
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}

