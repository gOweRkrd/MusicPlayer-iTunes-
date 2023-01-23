//
//  UserInfoViewController.swift
//  MusicPlayer
//
//  Created by Артем Галай on 19.01.23.
//

import UIKit

final class UserInfoViewController: UIViewController {
    
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
        setupDelegate()
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
            }
        }
    }
    
    private func setupDelegate() {
        customView.userInfoTableView.dataSource = self
        customView.userInfoTableView.delegate = self
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

// MARK: - UITableViewDataSource

extension UserInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension UserInfoViewController: UITableViewDelegate {
}
