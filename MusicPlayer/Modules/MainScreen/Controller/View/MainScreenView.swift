import UIKit

final class MainScreenView: UIView {

    // MARK: - UI Elements
    
     let selectorCountriesView = SelectorCountriesView()
    
     let greetingLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Hello!"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .interRegular(size: 16)
        return label
    }()
    
    lazy var popularAlbumsCollectionView: UICollectionView = {
       
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .horizontal
       layout.itemSize = CGSize(width: 150, height: 150)
       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       collectionView.showsHorizontalScrollIndicator = false
       collectionView.register(PopularAlbumsCell.self, forCellWithReuseIdentifier: "cell")
       collectionView.backgroundColor = .clear
       return collectionView
   }()

    lazy var tableView: UITableView = {
       
       let tableView = UITableView()
       tableView.backgroundColor = .clear
       tableView.register(TopCountryCell.self, forCellReuseIdentifier: "cell")
       return tableView
   }()
    
    private let questionLabel: UILabel = {
        
        let label = UILabel()
        label.text = "What You want to hear today?"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .interRegular(size: 14)
        return label
    }()

    private let popularAlbumsLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Popular Artists"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .interBold(size: 18)
        return label
    }()
    
    private let topCountryLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Top chart in countries"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .interBold(size: 18)
        return label
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Setup Constrains

extension MainScreenView {
    
    private func setupViews() {
        self.backgroundColor = UIColor(named: "mainColor")
        self.addSubviews([greetingLabel,
                          questionLabel,
                          popularAlbumsLabel,
                          popularAlbumsCollectionView,
                          topCountryLabel,
                          tableView,
                          selectorCountriesView])

        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: .greetingLabelTopMargin),
            greetingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .leadingMargin),
            greetingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .trailingMargin),

            questionLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: .questionLabelTopMargin),
            questionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .leadingMargin),
            questionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .trailingMargin),

            popularAlbumsLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: .popularTopMargin),
            popularAlbumsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .leadingMargin),
            popularAlbumsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .trailingMargin),

            popularAlbumsCollectionView.topAnchor.constraint(equalTo: popularAlbumsLabel.bottomAnchor, constant: .popularTopMargin),
            popularAlbumsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .leadingMargin),
            popularAlbumsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .trailingMargin),
            popularAlbumsCollectionView.heightAnchor.constraint(equalToConstant: .popularAlbumsCollectionHeight),

            topCountryLabel.topAnchor.constraint(equalTo: popularAlbumsCollectionView.bottomAnchor, constant: .topCountryLabelTopMargin),
            topCountryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .leadingMargin),
            topCountryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .trailingMargin),

            selectorCountriesView.topAnchor.constraint(equalTo: topCountryLabel.bottomAnchor),
            selectorCountriesView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .leadingMargin),
            selectorCountriesView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .trailingMargin),
            selectorCountriesView.heightAnchor.constraint(equalToConstant: .selectorCountriesHeight),

            tableView.topAnchor.constraint(equalTo: selectorCountriesView.bottomAnchor, constant: .popularTopMargin),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .leadingMargin),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .trailingMargin),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - Constant Constrains

private extension CGFloat {
    static let leadingMargin: CGFloat = 10
    static let trailingMargin: CGFloat = -10
    static let greetingLabelTopMargin: CGFloat = 50
    static let questionLabelTopMargin: CGFloat = 5
    static let topCountryLabelTopMargin: CGFloat = 30
    static let popularTopMargin: CGFloat = 10
    static let popularAlbumsCollectionHeight: CGFloat = 150
    static let selectorCountriesHeight: CGFloat = 50
}
