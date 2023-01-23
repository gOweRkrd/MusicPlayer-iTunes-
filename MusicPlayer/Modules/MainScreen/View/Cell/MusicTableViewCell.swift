//
//  MusicTableViewCell.swift
//  MusicPlayer
//
//  Created by Админ on 11.01.2023.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    static let indetifire = "MusicTableViewCell"

     let imageBack: UIImageView = {
        let imageBack = UIImageView()
        imageBack.image = UIImage(named: "1111")
        imageBack.layer.cornerRadius = 20
        imageBack.clipsToBounds = true
        imageBack.contentMode = .scaleToFill
        return imageBack
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play.circle.fill"), for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 30
        return button

    }()

    private lazy var songLbl: UILabel = {
        let label = UILabel()
        label.text = "La Ritournelle"
        label.font = UIFont.systemFont(ofSize: 19)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    private lazy var artistLbl: UILabel = {
        let label = UILabel()
        label.text = "Sébastien Tellier"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    private lazy var timeLbl: UILabel = {
        let label = UILabel()
        label.text = "2:35"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .cyan
        return label
    }()

    private lazy var longLbl: UILabel = {
        let label = UILabel()
        label.text = "5:00"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createConfig()
        setupConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 20
    }

    func createConfig() {
        [imageBack, playButton, songLbl, artistLbl, timeLbl, longLbl].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([

            imageBack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageBack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageBack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imageBack.heightAnchor.constraint(equalToConstant: 32),
            imageBack.widthAnchor.constraint(equalToConstant: 90),

            playButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            playButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 310),
            playButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),

            songLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            songLbl.leadingAnchor.constraint(equalTo: imageBack.trailingAnchor, constant: 10 ),
            songLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            songLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),

            artistLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            artistLbl.leadingAnchor.constraint(equalTo: imageBack.trailingAnchor, constant: 10 ),
            artistLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            artistLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),

            timeLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            timeLbl.leadingAnchor.constraint(equalTo: imageBack.trailingAnchor, constant: 10 ),
            timeLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            timeLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            longLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            longLbl.leadingAnchor.constraint(equalTo: timeLbl.leadingAnchor, constant: 45 ),
            longLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            longLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)

        ])
    }

}

import SwiftUI

struct PeopleVCProvider: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
            .previewDevice("iPhone 14 Pro ")
    }

    struct Container: UIViewControllerRepresentable {

        let tabBarVC = MainScreenViewController()

        func makeUIViewController(context: Context) -> some UIViewController {
            tabBarVC
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

        }
    }
}
