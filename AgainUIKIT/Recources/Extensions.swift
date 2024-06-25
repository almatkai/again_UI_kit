//
//  Extensions.swift
//  AgainUIKIT
//
//  Created by Almat Kairatov on 24.06.2024.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView ...) {
        views.forEach({
            addSubview($0)
        })
    }
}
