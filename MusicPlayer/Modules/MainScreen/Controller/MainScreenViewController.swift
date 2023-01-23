//
//  MainScreenViewController.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 17.01.2023.
//

import UIKit
import AVKit

class MainScreenViewController: UIViewController {
    
    private var artists = ArtistModel.createArtists()
    private var countryTracks = [TrackModel]()
    
    private let selectorCountriesView = SelectorCountriesView()
    private let cellReuseIdentifier = "cell"
    private let identifierCollectionView = "cell"
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello!"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .interRegular(size: 16)
        return label
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
    
    private lazy var popularAlbumsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 150)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PopularAlbumsCell.self, forCellWithReuseIdentifier: identifierCollectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TopCountryCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let topCountryLabel: UILabel = {
        let label = UILabel()
        label.text = "Top chart in countries"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .interBold(size: 18)
        return label
    }()
    
    private let musicManager = MusicManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchAlbum(from: .usa)
        selectorCountriesView.delegate = self
        fetchInfoUser()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "mainColor")
        view.addSubviews([greetingLabel,
                          questionLabel,
                          popularAlbumsLabel,
                          popularAlbumsCollectionView,
                          topCountryLabel,
                          tableView,
                          selectorCountriesView])
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: .greetingLabelTopMargin),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leadingMargin),
            greetingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .trailingMargin),
            
            questionLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: .questionLabelTopMargin),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leadingMargin),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .trailingMargin),
            
            popularAlbumsLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: .popularTopMargin),
            popularAlbumsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leadingMargin),
            popularAlbumsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .trailingMargin),
            
            popularAlbumsCollectionView.topAnchor.constraint(equalTo: popularAlbumsLabel.bottomAnchor, constant: .popularTopMargin),
            popularAlbumsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leadingMargin),
            popularAlbumsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .trailingMargin),
            popularAlbumsCollectionView.heightAnchor.constraint(equalToConstant: .popularAlbumsCollectionHeight),
            
            topCountryLabel.topAnchor.constraint(equalTo: popularAlbumsCollectionView.bottomAnchor, constant: .topCountryLabelTopMargin),
            topCountryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leadingMargin),
            topCountryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .trailingMargin),
            
            selectorCountriesView.topAnchor.constraint(equalTo: topCountryLabel.bottomAnchor),
            selectorCountriesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leadingMargin),
            selectorCountriesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .trailingMargin),
            selectorCountriesView.heightAnchor.constraint(equalToConstant: .selectorCountriesHeight),
            
            tableView.topAnchor.constraint(equalTo: selectorCountriesView.bottomAnchor, constant: .popularTopMargin),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .leadingMargin),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .trailingMargin),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchInfoUser() {
        AuthService.shared.fetchUser { user, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let user = user {
                self.greetingLabel.text = "Hello, \(user.username)"
            }
        }
    }
    
    
    private func fetchAlbum(from country: Country) {
        NetworkManager.shared.getAllMusic(from: country) { [self] result in
            switch result {
            case .success(let album):
                DispatchQueue.main.async {
                    self.countryTracks = album.results.filter { $0.trackName != nil && $0.previewUrl != nil }
                    self.tableView.reloadData()
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MainScreenViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        artists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCollectionView, for: indexPath) as? PopularAlbumsCell else {
            return UICollectionViewCell()
        }
        cell.setup(album: artists[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MainScreenViewController: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artistVC = ArtistScreenViewController()
        artistVC.nameArtist = artists[indexPath.item].name
        navigationController?.pushViewController(artistVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MainScreenViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TopCountryCell else {
            return UITableViewCell()
        }
        let album = countryTracks[indexPath.row]
        let config = TopCountryCellConfig(nameArtist: album.artistName,
                                          nameTrack: album.trackName,
                                          minutesTrack: album.trackTimeMillis,
                                          imageURL: album.artworkUrl100)
        cell.setup(config: config)
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

extension MainScreenViewController: TopCountryCellDelegate {
    func didTapPlayButton(with index: Int?) {
        guard let index else {
            return
        }
        
        musicManager.createTrackList(countryTracks)
        musicManager.playTrack(by: index)
    }
}

extension MainScreenViewController: SelectorCountriesViewDelegate {
    
    // MARK: - SelectorCountriesViewDelegate
    
    func didTapCountryButton(_ country: Country) {
        fetchAlbum(from: country)
    }
}
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


