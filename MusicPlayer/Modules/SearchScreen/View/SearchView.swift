import UIKit

final class SearchView: UIView {
    
    // MARK: - Properties
    
     lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    lazy var searchTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Search track and artist"
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: "cell")
        backgroundColor = .white

        addSybView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Setup Constrains

private extension SearchView {
    
    func addSybView() {
        addSubview(tableView)
        addSubview(searchTextField)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .searchTextFieldSize),
            searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -.searchTextFieldSize),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: .searchTextFieldSize),
            searchTextField.heightAnchor.constraint(equalToConstant:.searchTextFieldHightAnchor),
        
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant:.myTableViewTopAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - Constant Constraints

extension CGFloat {
    static let myTableViewTopAnchor: CGFloat = 15
    static let searchTextFieldSize: CGFloat = 10
    static let searchTextFieldHightAnchor: CGFloat = 40
}


