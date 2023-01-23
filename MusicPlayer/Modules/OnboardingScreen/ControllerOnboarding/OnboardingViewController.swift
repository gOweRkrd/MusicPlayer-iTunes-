import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    
    private let onboardingView = OnboardingView()
    private var isNextButtonTapped = false

    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupNavigationItem()
        saveUserDefaults()
        onboardingView.nextButton.addTarget(self, action: #selector(goNextStep(_:)), for: .touchUpInside)
    }
    
    // MARK: - Private Methods
    
    private func saveUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "OnBoardingWasViewed")
    }
    
    private func setupNavigationItem() {
        let rightItem = UIBarButtonItem(title: "Skip",
                                        image: nil,
                                        target: self,
                                        action: #selector(skipOnboarding))
        rightItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc
    private func skipOnboarding() {
        dismiss(animated: true)
    }
    
    @objc
    private func goNextStep(_ sender: UIButton) {
        if isNextButtonTapped {
            skipOnboarding()
        } else {
            onboardingView.imageView.image = UIImage(named: "OnboardingSecond")
            onboardingView.nextButton.setTitle("Start", for: .normal)
            onboardingView.welcomeLabel.text = "Download and save your Favourit Music"
            onboardingView.descriptionLabel.text = "Your best music is always with you 🎧"
            navigationItem.rightBarButtonItem?.isHidden = true
            isNextButtonTapped = true
        }
    }
}
