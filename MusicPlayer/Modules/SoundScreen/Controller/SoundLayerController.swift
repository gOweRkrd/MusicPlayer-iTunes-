//
//  SoundLayerController.swift
//  MusicPlayer
//
//  Created by Александр Косяков on 08.01.2023.
//

import UIKit

final class SoundLayerController: UIViewController {
    
    // MARK: - Properties
    
    private let soundView = SoundLayerView()
    private var trackList = [TrackModel]()
    
    
    private let musicManager = MusicManager.shared
    private let storageManager = StorageManager.shared
    private var isFavorite = false
    
    var data: TrackModel? {
        didSet {
            guard let data = data else { return }
            soundView.authorLabel.text = data.artistName
            soundView.nameMusicLabel.text = data.trackName
            
            guard let imageURL = data.artworkUrl100 else {
                return
            }
            soundView.activityIndicator.startAnimating()
            NetworkManager.shared.downloadImage(from: imageURL) { image in
                DispatchQueue.main.async { [self] in
                    soundView.imageViewMain.image = image
                    soundView.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = soundView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getMusicData()
    }
    
    private func setupTitle(backgroundColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupTarget() {
        soundView.playButton.addTarget(self, action: #selector(playBut), for: .touchUpInside)
        soundView.musicSlider.addTarget(self, action: #selector(sliderBut), for: .touchUpInside)
        soundView.favouritesButton.addTarget(self, action: #selector(favouritesTapButton), for: .touchUpInside)
        soundView.leftButton.addTarget(self, action: #selector(leftBut), for: .touchUpInside)
        soundView.rightButton.addTarget(self, action: #selector(rightBut), for: .touchUpInside)
    }
    
    private func setupPlayer() {
        musicManager.observeTrack { [self] observeTrackModel, isNextTrack  in
            guard let observeTrackModel else {
                if isNextTrack {
                    getMusicData()
                }
                return
            }
            
            soundView.musicSlider.maximumValue = observeTrackModel.maximumValue
            soundView.musicSlider.value = observeTrackModel.currentValue
            soundView.minuteStartLabel.text = observeTrackModel.startTime
            soundView.minuteFinishLabel.text = observeTrackModel.finishTime
        }
    }

    private func changeFavorite(isFavorite: Bool) {
        if isFavorite {
            soundView.favouritesButton.setImage(UIImage(named: "heart1"), for: .normal)
        } else {
            soundView.favouritesButton.setImage(UIImage(named: "heart2"), for: .normal)
        }
    }
    
    @objc private func playBut () {
        if musicManager.isPlayed {
            soundView.playButton.setImage(UIImage(named: "play"), for: .normal)
            musicManager.pauseTrack()
        } else {
            soundView.playButton.setImage(UIImage(named: "pause"), for: .normal)
            musicManager.playTrack()
        }
    }
    
    @objc private func sliderBut () {
        musicManager.changeTrackTime(value: Double(soundView.musicSlider.value))
    }
    
    @objc private func favouritesTapButton () {
        guard let data else {
            return
        }
        
        if isFavorite {
            storageManager.delete(data)
        } else {
            storageManager.saveTrack(data)
        }
        isFavorite.toggle()
        changeFavorite(isFavorite: isFavorite)
    }
    
    @objc private func leftBut () {
        musicManager.previousTrack()
        getMusicData()
    }
    
    @objc private func rightBut () {
        musicManager.nextTrack()
        getMusicData()
    }
    
    private func getMusicData() {
        if let model = musicManager.getModel() {
            data = model
            soundView.playButton.setImage(UIImage(named: musicManager.isPlayed ? "pause" : "play"),
                                          for: .normal)
            if storageManager.hasModel(model) {
                changeFavorite(isFavorite: true)
                isFavorite = true
            } else {
                changeFavorite(isFavorite: false)
                isFavorite = false
            }
            setupPlayer()
        }
    }
}
