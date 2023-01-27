import UIKit

final class UserInfoController: UIViewController {
    
    // MARK: - Properties

    private var categories = UserInfoModel.categories
    private let customView = UserInfoView()
    
    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInfoUser()
        customView.logOutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)

    }
    
    // MARK: - Private Methods
    
    private func fetchInfoUser() {
        AuthService.shared.fetchUser { user, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let user = user {
                self.customView.titleLabel.text = "Welcome, \(user.username)"
                self.customView.nameUser.text = "name: \(user.username)"
                self.customView.emailUser.text = "email: \(user.email)"
            }
        }
    }

    @objc
    private func didTapLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }

            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}

