//
//  CountryButtonView.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 18.01.2023.
//

import UIKit

final class CountryButtonView: UIButton {

    var name: Country = .usa

    private let countryLabel: UILabel = {
        let label = UILabel()
        label.text = "RU"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .interBold(size: 15)
        return label
    }()

    private let bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        return bottomView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(country: Country) {
        self.init(frame: .zero)
        bottomView.isHidden = true
        countryLabel.text = country.rawValue
        name = country
    }

    func didTapButton(_ isTapped: Bool) {
        countryLabel.textColor = isTapped ? .cyan : .white
        bottomView.backgroundColor = isTapped ? .cyan : .white
        bottomView.isHidden = !isTapped
    }

    private func configure() {
        backgroundColor = .clear
        addSubviews([countryLabel, bottomView])

        NSLayoutConstraint.activate([
            countryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .leadingMargin),
            countryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .trailingMargin),
            countryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .bottomMargin),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .leadingBottomMargin),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .trailingBottomMargin),
            bottomView.heightAnchor.constraint(equalToConstant: .bottomHeight)
        ])

    }
}

private extension CGFloat {
    static let leadingMargin: CGFloat = 10
    static let trailingMargin: CGFloat = -10
    static let bottomMargin: CGFloat = 1
    static let leadingBottomMargin: CGFloat = 5
    static let trailingBottomMargin: CGFloat = -5
    static let bottomHeight: CGFloat = 5
}
