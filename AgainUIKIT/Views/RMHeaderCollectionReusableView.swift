//
//  HeaderCollectionReusableView.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 09.07.2024.
//

import UIKit

class RMHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "RMHeaderCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        setupConstrainsts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    func setLabelText(text: String) {
        label.text = text
    }
    
    private func setupConstrainsts() {
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
