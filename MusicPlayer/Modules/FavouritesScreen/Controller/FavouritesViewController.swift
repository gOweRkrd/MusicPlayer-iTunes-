//
//  FavouritesViewController.swift
//  MusicPlayer
//
//  Created by Александр Косяков on 09.01.2023.
//

import UIKit

final class FavouritesViewController: UIViewController {

    // MARK: - Properties

    private let favouritesView = FavouritesView()
    private var trackList = [TrackModel]()

    private let musicManager = MusicManager.shared
    private let storageManager = StorageManager.shared

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        self.view = favouritesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegate()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        trackList = storageManager.fetchItems()
        favouritesView.tableView.reloadData()

        if trackList.isEmpty {
            showEmptyStateView()
        } else {
            removeEmptyStateView()
        }
    }

    // MARK: - Private Methods

    private func setupDelegate() {
        favouritesView.tableView.dataSource = self
        favouritesView.tableView.delegate = self

    }
    
    private func showEmptyStateView() {
        view.bringSubviewToFront(favouritesView.emptyStateView)

    }

    private func removeEmptyStateView() {
        view.bringSubviewToFront(favouritesView.tableView)

    }
}

// MARK: - TableViewDataSource

extension FavouritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? FavouritiesCell  else {
            fatalError("Creating cell from HotelsListViewController failed")
        }
        cell.delegate = self
        cell.index = indexPath.row
        cell.data = trackList[indexPath.row]

        return cell
    }
}

// MARK: - TableViewDelegate

extension FavouritesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] _, _, _ in
            let track = trackList[indexPath.row]
            storageManager.delete(track)
            trackList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if trackList.isEmpty {
                showEmptyStateView()
            } else {
                removeEmptyStateView()
            }
        }
        deleteAction.backgroundColor = .systemMint
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let soundVC = SoundLayerController()

        soundVC.data = trackList[indexPath.row]
        navigationController?.pushViewController(soundVC, animated: true)
    }
}

// MARK: - FavouritiesCellDelegate

extension FavouritesViewController: FavouritiesCellDelegate {
    
    func didTapPlayButton(with index: Int?) {
        guard let index else {
            return
        }
        musicManager.createTrackList(trackList)
        musicManager.playTrack(by: index)
    }
}
