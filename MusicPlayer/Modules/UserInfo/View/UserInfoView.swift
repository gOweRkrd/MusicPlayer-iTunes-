import UIKit

final class UserInfoView: BaseView {
    
    // MARK: - UI Elements
    
    let titleLabel = TitleLabel(title: "Welcome")
    let logOutButton = DefaultButton(titleText: "LogOut")

    let userInfoTableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func addSubviews() {
        super.addSubviews()
        addSubview(userInfoTableView)
        addSubview(titleLabel)
        addSubview(logOutButton)
    }
    
    // MARK: - Setup Constrains

    override func makeConstraints() {
        super.makeConstraints()
        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            userInfoTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            userInfoTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userInfoTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            userInfoTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -200),

            logOutButton.topAnchor.constraint(equalTo: userInfoTableView.bottomAnchor, constant: 20),
            logOutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            logOutButton.widthAnchor.constraint(equalToConstant: 200),
            logOutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
