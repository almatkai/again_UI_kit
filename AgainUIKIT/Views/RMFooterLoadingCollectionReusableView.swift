//
//  RMFooterLoadingCollectionReuseableView.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 26.06.2024.
//

import UIKit

class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "RMFooterLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.leftAnchor.constraint(equalTo: leftAnchor),
            spinner.rightAnchor.constraint(equalTo: rightAnchor),
            spinner.topAnchor.constraint(equalTo: topAnchor),
            spinner.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
