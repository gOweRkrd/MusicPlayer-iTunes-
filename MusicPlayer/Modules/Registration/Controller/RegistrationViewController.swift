//
//  RegistrationViewController.swift
//  MusicPlayer
//
//  Created by Артем Галай on 12.01.23.
//

import UIKit
import FirebaseAuth
import Firebase

final class RegistrationViewController: UIViewController {
    
    // MARK: - Properties
    
    private let customView = RegistrationView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showOnboarding()
    }
    
    // MARK: - PrivateMethods
    
    private func addTarget() {
        customView.singInButton.addTarget(self, action: #selector(singInButtonTapped), for: .touchUpInside)
        customView.signInLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLabel)))
    }
    
    private func showOnboarding() {
        let userDefaults = UserDefaults.standard
        let onBoardingWasViewed = userDefaults.bool(forKey: "OnBoardingWasViewed")
        if !onBoardingWasViewed {
            let onboardingViewController = OnboardingViewController()
            onboardingViewController.modalPresentationStyle = .fullScreen
            present(onboardingViewController, animated: false)
        }
    }
    
    @objc
    private func singInButtonTapped() {
        let registerUserRequest = RegisterUserRequest(username: customView.nameTextField.text ?? "",
                                                      email: customView.emailTextField.text ?? "",
                                                      password: customView.passwordTextField.text ?? "")
        // Username check
        if !Validator.isValidUsername(for: registerUserRequest.username) {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        
        // Email check
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }
    
    @objc
    private func tapLabel(gesture: UITapGestureRecognizer) {
        let range = (customView.signInLabel.text as? NSString ?? "").range(of: "Sign in")
        
        if gesture.didTapAttributedTextInLabel(label: customView.signInLabel, inRange: range) {
            let viewController = LoginViewController()
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
