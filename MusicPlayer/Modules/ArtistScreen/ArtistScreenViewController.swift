//
//  ArtistScreenViewController.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 18.01.2023.
//

import UIKit

class ArtistScreenViewController: UIViewController {
    
    var nameArtist: String?

    private let cellReuseIdentifier = "cell"
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TrackListCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var trackList = [TrackModel]()
    
    private let musicManager = MusicManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupView()
        getTracksArtist()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTitle(backgroundColor: UIColor(named: "mainColor") ?? .black)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setupTitle(backgroundColor: .clear)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "mainColor")
        view.addSubviews([tableView])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTitle(backgroundColor: UIColor) {
        title = nameArtist
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func getTracksArtist() {
        guard let nameArtist else {
            return
        }
        
        NetworkManager.shared.getArtistAlbum(name: nameArtist) { result in
            switch result {
            case .success(let album):
                DispatchQueue.main.async { [self] in
                    trackList = album.results.filter { $0.trackName != nil && $0.previewUrl != nil }
                    tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ArtistScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TrackListCell else { return UITableViewCell() }
        cell.setup(nameTrack: trackList[indexPath.row].trackName, index: indexPath.row)
        cell.delegate = self
        cell.backgroundColor = UIColor(named: "mainColor")
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ArtistScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

// MARK: - TrackListCellDelegate

extension ArtistScreenViewController: TrackListCellDelegate {
    
    func didTapPlayButton(with index: Int?) {
        guard let index else {
            return
        }
        musicManager.createTrackList(trackList)
        musicManager.playTrack(by: index)
        
    }
}

