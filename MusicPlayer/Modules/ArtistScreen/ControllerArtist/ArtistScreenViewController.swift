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
        
        getTracksArtist()
        artistViewScreen.tableView.dataSource = self
        artistViewScreen.tableView.delegate = self
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
    
    // MARK: - Private Methods
    
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
        didTapPlayButton(with: indexTrack)
        navigationController?.pushViewController(soundVC, animated: true)
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

