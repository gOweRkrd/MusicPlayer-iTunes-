import UIKit
import AVKit

final class MainScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mainViewScreen = MainScreenView()
    private var artists = ArtistModel.createArtists()
    private var countryTracks = [TrackModel]()
    private let musicManager = MusicManager.shared
    private var indexTrack = 0
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = mainViewScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewScreen.popularAlbumsCollectionView.dataSource = self
        mainViewScreen.popularAlbumsCollectionView.delegate = self
        mainViewScreen.tableView.dataSource = self
        mainViewScreen.tableView.delegate = self
        
        fetchAlbum(from: .usa)
        mainViewScreen.selectorCountriesView.delegate = self
        fetchInfoUser()
    }
    
    // MARK: - Private Methods
    
    private func fetchInfoUser() {
        AuthService.shared.fetchUser { [self] user, error in
            if let error = error {
                print(error.localizedDescription)
            }
            if let user = user {
                mainViewScreen.greetingLabel.text = "Hello, \(user.username)"
            }
        }
    }
    
    private func fetchAlbum(from country: Country) {
        NetworkManager.shared.getAllMusic(from: country) { [self] result in
            switch result {
                case .success(let album):
                    DispatchQueue.main.async {
                        self.countryTracks = album.results.filter { $0.trackName != nil && $0.previewUrl != nil }
                        mainViewScreen.tableView.reloadData()
                        
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "cell", for: indexPath) as? PopularAlbumsCell else {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let soundVC = SoundLayerController()
        soundVC.data = countryTracks[indexPath.row]
        navigationController?.pushViewController(soundVC, animated: true)
        // playback of the current track after switching to the music screen
        let indexTrack = countryTracks.indices[indexPath.row]
        didTapPlayButton(with: indexTrack)
    }
}

extension MainScreenViewController: TopCountryCellDelegate {
    func didTapPlayButton(with index: Int?) {
        guard let index else {
            return
        }
        indexTrack = index
        musicManager.createTrackList(countryTracks)
        musicManager.playTrack(by: index)
    }
}

// MARK: - SelectorCountriesViewDelegate

extension MainScreenViewController: SelectorCountriesViewDelegate {
    
    func didTapCountryButton(_ country: Country) {
        fetchAlbum(from: country)
    }
}
