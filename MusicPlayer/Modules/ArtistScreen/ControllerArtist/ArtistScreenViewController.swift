import UIKit

final class ArtistScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    var nameArtist: String?
    
    private let musicManager = MusicManager.shared
    private let artistViewScreen = ArtistViewScreen()
    private var indexTrack = 0
    private var trackList = [TrackModel]()
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = artistViewScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = nameArtist
        navigationController?.navigationBar.tintColor = .white
        getTracksArtist()
        artistViewScreen.tableView.dataSource = self
        artistViewScreen.tableView.delegate = self
    }
    
    // MARK: - Private Methods
    
    private func getTracksArtist() {
        guard let nameArtist else {
            return
        }
        
        NetworkManager.shared.getArtistAlbum(name: nameArtist) { result in
            switch result {
                case .success(let album):
                    DispatchQueue.main.async { [self] in
                        trackList = album.results.filter { $0.trackName != nil && $0.previewUrl != nil }
                        artistViewScreen.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let soundVC = SoundLayerController()
        soundVC.data = trackList[indexPath.row]
        navigationController?.pushViewController(soundVC, animated: true)
        // playback of the current track after switching to the music screen
        let indexTrack = trackList.indices[indexPath.row]
        didTapPlayButton(with: indexTrack)
    }
}
// MARK: - TrackListCellDelegate

extension ArtistScreenViewController: TrackListCellDelegate {
    
    func didTapPlayButton(with index: Int?) {
        guard let index else {
            return
        }
        indexTrack = index
        musicManager.createTrackList(trackList)
        musicManager.playTrack(by: index)
    }
}

