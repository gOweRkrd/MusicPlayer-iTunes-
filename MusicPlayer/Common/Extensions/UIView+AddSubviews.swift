//
//  UIView+Ext.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 08.01.2023.
//

import UIKit

extension UIView {

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
