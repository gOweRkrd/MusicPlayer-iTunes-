//
//  DetailUserViewController.swift
//  MusicPlayer
//
//  Created by Артем Галай on 19.01.23.
//

import UIKit

final class DetailUserViewController: UIViewController {
    
    // MARK: - UI Elements

    let titleLabel = TitleLabel(title: "You are don't register!")
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup Constrains

    private func setupHierarchy() {
        view.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
