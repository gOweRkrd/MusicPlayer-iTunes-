//
//  RegistrationView.swift
//  MusicPlayer
//
//  Created by Артем Галай on 12.01.23.
//

import UIKit

private extension CGFloat {
    static let height: CGFloat = 50
    static let logoHeight: CGFloat = 74
}

final class RegistrationView: BaseView {

    let singInButton = DefaultButton(titleText: "Sing in")

    let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account? Sign in"
        label.textColor = .white
        label.font = .interRegular(size: 16)
        label.isUserInteractionEnabled = true
        label.textAlignment = .center

        let attributeLabel = NSMutableAttributedString(string: label.text ?? "")
        let range = (label.text as? NSString)?.range(of: "Sign in")
        attributeLabel.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 16),
                                    range: range ?? NSRange())
        attributeLabel.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemMint,
                                    range: range ?? NSRange())
        label.attributedText = attributeLabel

        let tapGesture = UITapGestureRecognizer()
        label.addGestureRecognizer(tapGesture)
        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = CGFloat.baseLightSpacing
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
        label.text = "Welcome to Music Player"
        label.textAlignment = .center
        label.font = .poppinsBold(size: 24)
        label.textColor = .cyan
        return label
    }()

    private let title = TitleLabel(title: "Create your account")

    private let nameLabel = DescriptionLabel(title: "Name")

    let nameTextField = DefaultTextField(placeholder: "Name", isSecureTextEntry: false)

    private let emailLabel = DescriptionLabel(title: "Email address")

    let emailTextField = DefaultTextField(placeholder: "Email", isSecureTextEntry: false)

    private let passwordLabel = DescriptionLabel(title: "Password")

    let passwordTextField = DefaultTextField(placeholder: "Password", isSecureTextEntry: true)

    override func addSubviews() {
        super.addSubviews()
        addSubview(contentStackView)

        contentStackView.addArrangedSubviews([
            logoImage,
            name,
            title,
            nameLabel,
            nameTextField,
            emailLabel,
            emailTextField,
            passwordLabel,
            passwordTextField,
            singInButton,
            signInLabel
        ])
    }

    override func makeConstraints() {
        super.makeConstraints()
        NSLayoutConstraint.activate([

            contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.baseLightSpacing),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat.baseLightSpacing),
            contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),

            logoImage.heightAnchor.constraint(equalToConstant: CGFloat.logoHeight),
            title.heightAnchor.constraint(equalToConstant: CGFloat.height),
            name.heightAnchor.constraint(equalToConstant: CGFloat.height),

            nameTextField.heightAnchor.constraint(equalToConstant: CGFloat.height),

            emailTextField.heightAnchor.constraint(equalToConstant: CGFloat.height),

            passwordTextField.heightAnchor.constraint(equalToConstant: CGFloat.height),
            singInButton.heightAnchor.constraint(equalToConstant: CGFloat.height)
        ])

        contentStackView.setCustomSpacing(CGFloat.baseSpacing, after: emailLabel)
        contentStackView.setCustomSpacing(CGFloat.baseSpacing, after: name)
        contentStackView.setCustomSpacing(CGFloat.baseSpacing, after: passwordLabel)
        contentStackView.setCustomSpacing(CGFloat.baseSpacing, after: nameLabel)
    }
}
