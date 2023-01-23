//
//  SceneDelegate.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 08.01.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setupWindow(with: scene)
        self.checkAuthentication()
    }

    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
        FirebaseApp.configure()
    }

    public func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            goToController(with: UINavigationController(rootViewController: RegistrationViewController()))
        } else {
            goToController(with: TabBarController())
        }
    }

    private func goToController(with viewController: UIViewController) {
        let nav = viewController
        nav.modalPresentationStyle = .fullScreen
        window?.rootViewController = nav
    }
}
