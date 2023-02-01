import Foundation
import AVKit

final class MusicManager {
    
    // MARK: - Properties
    
    static let shared = MusicManager()
    
    private var trackList = [TrackModel]()
    private var previewUrl: String?
    private var index: Int?
    
    private(set) var isPlayed = false
    private var periodicTimeObserver: Any?
    private var closure: ((ObserveTrackModel?, Bool) -> Void)?
    
    private init() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
        } catch {
            fatalError("playback failed")
        }
    }
    
    private var player: AVPlayer? = {
        var avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    // MARK: - Public Methods
    
    func createTrackList(_ trackList: [TrackModel]) {
        self.trackList = trackList
    }
 
    func playTrack(by index: Int, mode: Int) {
        
        if mode == 0 {
            if trackList[index].previewUrl == previewUrl {
                isPlayed ? pauseTrack() : playTrack()
                return
            }
        } else if mode == 1 {
            if trackList[index].previewUrl == previewUrl {
                if isPlayed == true {
                    
                } else if isPlayed == false {
                    playTrack()
                }
                return
            }
        }
        if let periodicTimeObserver {
            player?.removeTimeObserver(periodicTimeObserver)
            self.periodicTimeObserver = nil
        }
        player = nil
        
        guard let previewUrl = trackList[index].previewUrl,
              let url = URL(string: previewUrl) else {
            return
        }
        
        self.previewUrl = previewUrl
        self.index = index
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        addObserver()
        playTrack()
    }
    
    func playTrack() {
        isPlayed = true
        player?.play()
    }
    
    func pauseTrack() {
        isPlayed = false
        player?.pause()
    }
    
    func observeTrack(completion: @escaping (ObserveTrackModel?, Bool) -> Void) {
        closure = completion
    }
    
    func changeTrackTime(value: Double) {
        player?.seek(to: CMTime(seconds: value, preferredTimescale: 1000))
    }
    
    func getModel() -> TrackModel? {
        if let index {
            return trackList[index]
        } else {
            return nil
        }
    }
    
    func nextTrack() {
        guard let index,
              trackList.count > 1 else {
            return
        }
        
        if index >= trackList.count-1 {
            self.index = 0
            playTrack(by: 0, mode: 0)
            playTrack(by: 0, mode: 1)
        } else {
            playTrack(by: index+1, mode: 0)
            playTrack(by: index+1, mode: 1)
        }
    }
    
    func previousTrack() {
        guard let index,
              trackList.count > 1 else {
            return
        }
        
        if index == 0 {
            self.index = trackList.count-1
            playTrack(by: trackList.count-1, mode: 0)
            playTrack(by: trackList.count-1, mode: 1)
        } else {
            playTrack(by: index-1, mode: 0)
            playTrack(by: index-1, mode: 1)
        }
    }
    
    // MARK: - Private Methods
    
    private func addObserver() {
        periodicTimeObserver = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1,
                                                                                   preferredTimescale: 1000),
                                                               queue: DispatchQueue.main) { [self] time in
            guard let player else {
                closure?(nil, false)
                return
            }
            let currentTime = player.currentItem?.duration ?? CMTime()
            let maximumValue = Float(player.currentItem?.duration.seconds ?? 0)
            let currentValue = Float(time.seconds)
            let startTime = convertTimeToString(time: time)
            let finishTime = convertTimeToString(time: currentTime - time)
            let model = ObserveTrackModel(maximumValue: maximumValue,
                                          currentValue: currentValue,
                                          startTime: startTime,
                                          finishTime: finishTime)
            if time.seconds >= currentTime.seconds {
                nextTrack()
                closure?(nil, true)
                return
            }
            
            closure?(model, false)
        }
    }
    
    private func convertTimeToString(time: CMTime) -> String {
        guard !CMTimeGetSeconds(time).isNaN else { return "" }
        let totalSeconds = Int(CMTimeGetSeconds(time))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormatString = String(
            format: "%02d:%02d", minutes, seconds
        )
        return timeFormatString
    }
}
