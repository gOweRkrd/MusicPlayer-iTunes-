//
//  PopularAlbumsCell.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 18.01.2023.
//

import UIKit

class PopularAlbumsCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.text = "Album name"
        label.font = .interBold(size: 14)
        label.textAlignment = .left
        label.textColor = .white
        
        label.numberOfLines = 2
        return label
    }()
    
    private let alphaView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColor")
        view.alpha = 0.3
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(album: ArtistModel) {
        imageView.image = album.image
        artistLabel.text = album.name
    }
    
    private func configure() {
        addSubviews([imageView, alphaView, artistLabel])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            alphaView.topAnchor.constraint(equalTo: topAnchor),
            alphaView.leadingAnchor.constraint(equalTo: leadingAnchor),
            alphaView.bottomAnchor.constraint(equalTo: bottomAnchor),
            alphaView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            artistLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .leadingMargin),
            artistLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .trailingMargin),
            artistLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .bottomMargin)
        ])
    }
}

private extension CGFloat {
    static let leadingMargin: CGFloat = 10
    static let trailingMargin: CGFloat = -10
    static let bottomMargin: CGFloat = -30
}
