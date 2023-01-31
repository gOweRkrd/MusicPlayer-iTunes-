import UIKit

final class SearchController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties

    private let searchView = SearchView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        searchView.searchTextField.addTarget(self, action: #selector(searchBut), for: .touchUpInside)
    }
    
    // MARK: - Private Method
    
    private func setupDelegate() {
        searchView.tableView.dataSource = self
        searchView.tableView.delegate = self
    }
    
    @objc
    private func searchBut () {

    }
}

// MARK: - TableViewDataSource

extension SearchController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchCell  else {
            fatalError("Creating cell from HotelsListViewController failed")
        }
        
        cell.textLabel?.text = "Экран в разработке"
        
        return cell
    }
}

// MARK: - TableViewDelegate

extension SearchController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

