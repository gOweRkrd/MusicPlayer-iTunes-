//
//  UIStackView+Ext.swift
//  MusicPlayer
//
//  Created by Артем Галай on 10.01.23.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview($0)
        }
    }
}
