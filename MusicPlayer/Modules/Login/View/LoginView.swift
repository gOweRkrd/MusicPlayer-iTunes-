//
//  LoginView.swift
//  MusicPlayer
//
//  Created by Артем Галай on 10.01.23.
//

import UIKit

private extension CGFloat {
    static let height: CGFloat = 50
    static let logoHeight: CGFloat = 74
    static let contentStackViewTopAnchor: CGFloat = 20
}

final class LoginView: BaseView {

    let singInButton = DefaultButton(titleText: "Sing in")

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = CGFloat.baseMediumSpacing
        return stackView
    }()

    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let name: UILabel = {
        let label = UILabel()
        label.text = "Music Player"
        label.textAlignment = .center
        label.font = .poppinsBold(size: 24)
        label.textColor = .cyan
        return label
    }()

    private let title = TitleLabel(title: "Sign in to your account")

    private let emailLabel = DescriptionLabel(title: "Email address")

    let emailTextField = DefaultTextField(placeholder: "Email", isSecureTextEntry: false)

    private let passwordLabel = DescriptionLabel(title: "Password")

    let passwordTextField = DefaultTextField(placeholder: "Password", isSecureTextEntry: true)

    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot your password?", for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .interRegular(size: 14)
        button.setTitleColor(.cyan, for: .normal)

        return button
    }()

    override func addSubviews() {
        super.addSubviews()
        addSubview(contentStackView)

        contentStackView.addArrangedSubviews([
            logoImage,
            name,
            title,
            emailLabel,
            emailTextField,
            passwordLabel,
            passwordTextField,
            forgotPasswordButton,
            singInButton
        ])
    }

    override func makeConstraints() {
        super.makeConstraints()
        NSLayoutConstraint.activate([

            contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: CGFloat.contentStackViewTopAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.baseLightSpacing),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat.baseLightSpacing),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),

            logoImage.heightAnchor.constraint(equalToConstant: CGFloat.logoHeight),
            title.heightAnchor.constraint(equalToConstant: CGFloat.height),
            name.heightAnchor.constraint(equalToConstant: CGFloat.height),
            emailTextField.heightAnchor.constraint(equalToConstant: CGFloat.height),
            passwordTextField.heightAnchor.constraint(equalToConstant: CGFloat.height),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: CGFloat.baseSpacing),
            singInButton.heightAnchor.constraint(equalToConstant: CGFloat.height)
        ])

        contentStackView.setCustomSpacing(CGFloat.baseSpacing, after: emailLabel)
        contentStackView.setCustomSpacing(CGFloat.baseSpacing, after: name)
        contentStackView.setCustomSpacing(CGFloat.baseSpacing, after: passwordLabel)
        contentStackView.setCustomSpacing(CGFloat.baseSpacing, after: passwordTextField)
    }
}
