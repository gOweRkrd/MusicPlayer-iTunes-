import UIKit
import FirebaseAuth
import Firebase

final class LoginController: UIViewController {
    
    // MARK: - Properties

    private let customView = LoginView()

    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tapToSingInButton()
    }
    
    // MARK: - Private Methods

    private func tapToSingInButton() {
        customView.singInButton.addTarget(self, action: #selector(singInButtonTapped), for: .touchUpInside)
    }

    @objc
    private func singInButtonTapped() {
        let loginRequest = LoginUserRequest(email: customView.emailTextField.text ?? "",
                                            password: customView.passwordTextField.text ?? "")

        // Email check
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }

        // Password check
        if !Validator.isPasswordValid(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }

        AuthService.shared.signIn(with: loginRequest) { error in
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }

            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}
