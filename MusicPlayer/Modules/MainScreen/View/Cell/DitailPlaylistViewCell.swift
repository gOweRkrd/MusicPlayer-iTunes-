//
//  DitailPlaylistViewCell.swift
//  MusicPlayer
//
//  Created by Nikita Borisov on 10.01.2023.
//

import UIKit

class DitailPlaylistViewCell: UICollectionViewCell {
    
    static let indetifire = "DitailPlaylistViewCell"
    
     let imageBack: UIImageView = {
        let imageBack = UIImageView()
        imageBack.image = UIImage(named: "1111")
        imageBack.layer.cornerRadius = 20
        imageBack.clipsToBounds = true
        imageBack.contentMode = .scaleToFill
        return imageBack
    }()
    
     lazy var nameLbl: UILabel = {
        let label = UILabel()
        label.text = "Friday mood!"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private lazy var disLbl: UILabel = {
        let label = UILabel()
        label.text = "Lets dance!"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play.circle.fill"), for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 30
        // button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createConfig()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createConfig() {
        [imageBack, nameLbl, disLbl, playButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        contentView.layer.shadowColor = UIColor.systemGray.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowRadius = 5
        contentView.layer.cornerRadius = 20
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 1
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBack.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageBack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageBack.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageBack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            nameLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLbl.heightAnchor.constraint(equalToConstant: 30),
            
            disLbl.topAnchor.constraint(equalTo: nameLbl.topAnchor, constant: 20),
            disLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            disLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            disLbl.heightAnchor.constraint(equalToConstant: 30),
            
            playButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 125),
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            playButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 120),
            playButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            playButton.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
}
