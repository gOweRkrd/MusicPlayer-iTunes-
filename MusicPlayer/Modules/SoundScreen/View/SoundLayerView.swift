//
//  SoundLayerView.swift
//  MusicPlayer
//
//  Created by Александр Косяков on 08.01.2023.
//

import UIKit

class SoundLayerView: UIView {

    // MARK: - UI Elements

    lazy var imageViewMain: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = .interRegular(size: 22)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    lazy var nameMusicLabel: UILabel = {
        let label = UILabel()
        label.font = .interRegular(size: 16)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    lazy var favouritesButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setImage(UIImage(named: "heart2"), for: .normal)
        return button
    }()

    lazy var musicSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .cyan
        slider.maximumTrackTintColor = .gray
        slider.thumbTintColor = .cyan
        return slider
    }()

    lazy var minuteStartLabel: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        label.font = .interRegular(size: 16)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    lazy var minuteFinishLabel: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        label.font = .interRegular(size: 16)
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()

    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.layer.masksToBounds = true
        return button
    }()

    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "left 1"), for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()

    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "right 1"), for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()

    lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 38
        return stack
    }()

    let activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor(named: "mainColor")
        activityIndicator.color = .cyan
        addSybView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Setup Constrains

extension SoundLayerView {

    func addSybView() {
        addSubviews([
            imageViewMain,
            authorLabel,
            nameMusicLabel,
            favouritesButton,
            musicSlider,
            minuteStartLabel,
            minuteFinishLabel,
            buttonStack
        ])

        [leftButton, playButton, rightButton].forEach { buttonStack.addArrangedSubview($0) }
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([
            imageViewMain.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageViewMain.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -.imageViewAnchor),
            imageViewMain.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: .imageViewAnchor),
            imageViewMain.heightAnchor.constraint(equalToConstant: 1.halfScreen),

            authorLabel.topAnchor.constraint(equalTo: imageViewMain.bottomAnchor, constant: .authorLabelTopAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .leadingTrailingAnchor),

            nameMusicLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: .topAnchor),
            nameMusicLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            nameMusicLabel.trailingAnchor.constraint(equalTo: favouritesButton.leadingAnchor, constant: .trailingMargin),

            favouritesButton.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: -.topAnchor),
            favouritesButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -.leadingTrailingAnchor),
            favouritesButton.heightAnchor.constraint(equalToConstant: .favoritesHeight),
            favouritesButton.widthAnchor.constraint(equalToConstant: .favoritesHeight),

            musicSlider.topAnchor.constraint(equalTo: nameMusicLabel.bottomAnchor, constant: .imageViewAnchor),
            musicSlider.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: .leadingTrailingAnchor),
            musicSlider.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -.leadingTrailingAnchor),

            minuteStartLabel.topAnchor.constraint(equalTo: musicSlider.bottomAnchor, constant: .topAnchor),
            minuteStartLabel.leadingAnchor.constraint(equalTo: musicSlider.leadingAnchor),

            minuteFinishLabel.topAnchor.constraint(equalTo: minuteStartLabel.topAnchor),
            minuteFinishLabel.trailingAnchor.constraint(equalTo: musicSlider.trailingAnchor),

            buttonStack.topAnchor.constraint(equalTo: minuteFinishLabel.bottomAnchor, constant: .buttonStackTopAnchor),
            buttonStack.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

// MARK: - Constant Constraints

private extension CGFloat {

    static let imageViewAnchor: CGFloat = 30
    static let topAnchor: CGFloat = 10
    static let trailingMargin: CGFloat = -10
    static let leadingTrailingAnchor: CGFloat = 15
    static let authorLabelTopAnchor: CGFloat = 75
    static let buttonStackTopAnchor: CGFloat = 15
    static let favoritesHeight: CGFloat = 30
}
