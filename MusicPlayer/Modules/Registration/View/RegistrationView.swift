import UIKit

final class RegistrationView: BaseView {
    
    // MARK: - UI Elements

    let singInButton = DefaultButton(titleText: "Sing in")
    let nameTextField = DefaultTextField(placeholder: "Name", isSecureTextEntry: false)
    let emailTextField = DefaultTextField(placeholder: "Email", isSecureTextEntry: false)
    let passwordTextField = DefaultTextField(placeholder: "Password", isSecureTextEntry: true)
    
    private let title = LabelSetup(title: "Create your account")
    private let nameLabel = DescriptionLabel(title: "Name")
    private let emailLabel = DescriptionLabel(title: "Email address")
    private let passwordLabel = DescriptionLabel(title: "Password")

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

    // MARK: - Setup Constrains
   
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

// MARK: - Constant Constrains

private extension CGFloat {
    static let height: CGFloat = 50
    static let logoHeight: CGFloat = 74
}

