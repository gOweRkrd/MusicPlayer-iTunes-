//
//  EmptyStateView.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 21.01.2023.
//

import UIKit

class EmptyStateView: UIView {
    
    // MARK: - UI Elements
    
    private lazy var messageLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = "Add your favorite music 🎧"
        label.font = .interBold(size: 18)
        label.textColor = .white
        return label
    }()
    
    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Constrains

    private func setupView() {
        addSubviews([messageLabel])

        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
