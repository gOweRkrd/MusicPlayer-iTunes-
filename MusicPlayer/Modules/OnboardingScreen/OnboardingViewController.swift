//
//  OnboardingFirstViewController.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 08.01.2023.
//

import UIKit
class OnboardingViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "OnboardingFirst")
        return imageView
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to the world of music"
        label.font = .poppinsBold(size: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "We are a small boutique music venue in the heart of internet"
        label.font = .poppinsRegular(size: 13)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = .white
        return label
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(goNextStep(_:)), for: .touchUpInside)
        button.layer.insertSublayer(createGradientToNextButton(), at: 0)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()

    private var isNextButtonTapped = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        setupView()
        setupNavigationItem()
        saveUserDefaults()
    }

    private func saveUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "OnBoardingWasViewed")
    }

    private func setupView() {
        view.addSubviews([imageView, welcomeLabel, descriptionLabel, nextButton])

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: .imageViewTopAnchor),
            imageView.heightAnchor.constraint(equalToConstant: .imageViewHeightAnchorAnchor),
            imageView.widthAnchor.constraint(equalToConstant: .imageViewHeightAnchorAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            welcomeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .welcomeLabelTopAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .welcomeDefaultOffset),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.welcomeDefaultOffset),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: .descriptionLabelTopAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            nextButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: .nextButtonTopAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .nextButtonTrailingAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: .nextButtonWidthAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: .nextButtonHeightAnchor)

        ])
    }

    private func setupNavigationItem() {
        let rightItem = UIBarButtonItem(title: "Skip",
                                        image: nil,
                                        target: self,
                                        action: #selector(skipOnboarding))
        rightItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightItem
    }

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

    @objc private func skipOnboarding() {
        dismiss(animated: true)
    }

    @objc private func goNextStep(_ sender: UIButton) {
        if isNextButtonTapped {
            skipOnboarding()
        } else {
            imageView.image = UIImage(named: "OnboardingSecond")
            nextButton.setTitle("Start", for: .normal)
            welcomeLabel.text = "Download and save your Favourit Music"
            descriptionLabel.text = "Your best music is always with you 🎧"
            navigationItem.rightBarButtonItem?.isHidden = true
            isNextButtonTapped = true
        }
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
