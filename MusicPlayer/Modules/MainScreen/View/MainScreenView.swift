//
//  File.swift
//  MusicPlayer
//
//  Created by Nikita Borisov on 09.01.2023.
//

import UIKit

class MainScreenView: UIView {
    
    // MARK: - UI
    
    lazy var helloLbl: UILabel = {
        let label = UILabel()
        label.text = "Hello Nikita,"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    lazy var questionLbl: UILabel = {
        let label = UILabel()
        label.text = "What You want to hear today?"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    lazy var justLbl: UILabel = {
        let label = UILabel()
        label.text = "What You want to hear today?"
        label.frame = CGRect(x: 5, y: 5, width: self.frame.width, height: self.frame.height)
        label.text = "Recently play"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        label.textColor = .white
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.layer.cornerRadius = 20
        search.backgroundColor = .clear
        search.sizeToFit()
        return search
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 50, left: 14, bottom: 50, right: 17)
        layout.minimumInteritemSpacing = 3
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DitailPlaylistViewCell.self, forCellWithReuseIdentifier: DitailPlaylistViewCell.indetifire)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: "MusicTableViewCell")
        return tableView
    }()
    
    lazy var recommendation: UIButton = {
        let button = UIButton()
        button.setTitle("Recommendation", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.cyan, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        // button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
        
    }()
    
    lazy var trending: UIButton = {
        let button = UIButton()
        button.setTitle("Trending", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.cyan, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        // button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
        
    }()
    
    lazy var beauty: UIButton = {
        let button = UIButton()
        button.setTitle("Beauty", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.cyan, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        // button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
        
    }()
    
    lazy var buisnes: UIButton = {
        let button = UIButton()
        button.setTitle("Buisnes", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(.cyan, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        // button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
        
    }()
    
    lazy var seeAll: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        // button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
        
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        createConfig()
        setConstraint()
        collectionView.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Constrains

extension MainScreenView {
    
    func createConfig() {
        [helloLbl, questionLbl, searchBar, collectionView, tableView, recommendation, trending, beauty, buisnes, justLbl, seeAll].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func setConstraint() {
        
        NSLayoutConstraint.activate([
            
            helloLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 35),
            helloLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            helloLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            helloLbl.heightAnchor.constraint(equalToConstant: 30),
            
            questionLbl.topAnchor.constraint(equalTo: helloLbl.bottomAnchor, constant: 1),
            questionLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            questionLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            questionLbl.heightAnchor.constraint(equalToConstant: 35),
            
            searchBar.topAnchor.constraint(equalTo: questionLbl.bottomAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 50),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            
            justLbl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            justLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            seeAll.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            seeAll.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 50),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            tableView.heightAnchor.constraint(equalToConstant: 350),
            
            recommendation.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            recommendation.trailingAnchor.constraint(equalTo: trending.leadingAnchor, constant: -5),
            recommendation.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            recommendation.heightAnchor.constraint(equalToConstant: 30),
            
            trending.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            trending.leadingAnchor.constraint(equalTo: recommendation.trailingAnchor, constant: 10),
            trending.trailingAnchor.constraint(equalTo: beauty.leadingAnchor, constant: -5),
            trending.heightAnchor.constraint(equalToConstant: 30),
            
            beauty.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            beauty.leadingAnchor.constraint(equalTo: trending.trailingAnchor, constant: 10),
            beauty.trailingAnchor.constraint(equalTo: buisnes.leadingAnchor, constant: -5),
            beauty.heightAnchor.constraint(equalToConstant: 30),
            
            buisnes.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            buisnes.leadingAnchor.constraint(equalTo: beauty.trailingAnchor, constant: 10),
            buisnes.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buisnes.heightAnchor.constraint(equalToConstant: 30)
            
        ])
        
    }
    
}
