import UIKit

final class OnboardingView: UIView {
    
    // MARK: - UI Elements

     let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "OnboardingFirst")
        return imageView
    }()

     lazy var welcomeLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Welcome to the world of music"
        label.font = .poppinsBold(size: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()

     lazy var descriptionLabel: UILabel = {
        
        let label = UILabel()
        label.text = "We are a small boutique music venue in the heart of internet"
        label.font = .poppinsRegular(size: 13)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = .white
        return label
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.insertSublayer(createGradientToNextButton(), at: 0)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - Private Methods
    
    private func createGradientToNextButton() -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        let firstColor = UIColor(named: "OnboardingNextButtonColor1") ?? .red
        let secondColor = UIColor(named: "OnboardingNextButtonColor2") ?? .red
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: 66, height: 40)
        return gradient
    }
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
    
// MARK: - Setup Constrains

extension OnboardingView {
    
    private func setupView() {
        self.addSubviews([imageView, welcomeLabel, descriptionLabel, nextButton])

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: .imageViewTopAnchor),
            imageView.heightAnchor.constraint(equalToConstant: .imageViewHeightAnchorAnchor),
            imageView.widthAnchor.constraint(equalToConstant: .imageViewHeightAnchorAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            welcomeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .welcomeLabelTopAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .welcomeDefaultOffset),
            welcomeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -.welcomeDefaultOffset),
            welcomeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: .descriptionLabelTopAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            nextButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: .nextButtonTopAnchor),
            nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .nextButtonTrailingAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: .nextButtonWidthAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: .nextButtonHeightAnchor)
        ])
    }
}

// MARK: - Constant Constraints

private extension CGFloat {
    static let imageViewTopAnchor: CGFloat = 225
    static let imageViewHeightAnchorAnchor: CGFloat = 207

    static let welcomeLabelTopAnchor: CGFloat = 24
    static let welcomeDefaultOffset: CGFloat = 80

    static let descriptionLabelTopAnchor: CGFloat = 8

    static let nextButtonTopAnchor: CGFloat = 49
    static let nextButtonTrailingAnchor: CGFloat = -29
    static let nextButtonWidthAnchor: CGFloat = 66
    static let nextButtonHeightAnchor: CGFloat = 40
}

    
    
