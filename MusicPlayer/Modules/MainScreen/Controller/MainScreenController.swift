//
//  File.swift
//  MusicPlayer
//
//  Created by Nikita Borisov on 09.01.2023.
//

import UIKit

class MainScreenViewController: UIViewController {

    private let mainView = MainScreenView()

    override func loadView() {
        super.loadView()
        self.view = mainView

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self

    }
}

extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DitailPlaylistViewCell.indetifire, for: indexPath) as? DitailPlaylistViewCell else {
            return UICollectionViewCell()
        }

        cell.layer.cornerRadius = 20

        return cell
    }

}

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width / 2.2, height: collectionView.frame.width / 2)

    }
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MusicTableViewCell.indetifire, for: indexPath) as? MusicTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120

    }

}
