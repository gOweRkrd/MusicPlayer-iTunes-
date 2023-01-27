import UIKit

final class UserInfoView: BaseView {
    
    // MARK: - UI Elements
    
    let titleLabel = TitleLabel(title: "Welcome")
    let nameUser = LabelSetup(title: "name")
    let emailUser = LabelSetup(title: "email")
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
        addSubview(titleLabel)
        addSubview(nameUser)
        addSubview(emailUser)
        addSubview(logOutButton)
    }
    
    // MARK: - Setup Constrains

    override func makeConstraints() {
        super.makeConstraints()
        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            nameUser.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 70),
            nameUser.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameUser.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            emailUser.topAnchor.constraint(equalTo: nameUser.bottomAnchor, constant: 30),
            emailUser.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            emailUser.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            logOutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            logOutButton.widthAnchor.constraint(equalToConstant: 200),
            logOutButton.heightAnchor.constraint(equalToConstant: 50),
            logOutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
        ])
    }
}
