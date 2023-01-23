//
//  DescriptionLabel.swift
//  MusicPlayer
//
//  Created by Артем Галай on 10.01.23.
//

import UIKit

final class DescriptionLabel: UILabel {

    init(title: String) {
        super.init(frame: .zero)
        text = title
        configureTitleLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTitleLabel() {
        font = .interRegular(size: 14)
        textAlignment = .left
        textColor = .white
    }
}
