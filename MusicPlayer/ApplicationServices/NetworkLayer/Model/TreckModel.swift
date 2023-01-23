//
//  Result.swift
//  MusicPlayer
//
//  Created by Админ on 14.01.2023.
//

import Foundation


struct AlbumResult: Decodable {
    let results: [TrackModel]
}

struct TrackModel: Decodable {
    let artistName: String
    let artistId: Int?
    let artworkUrl100: String?
    let previewUrl: String?
    let trackTimeMillis: Int? // delete to 60000 -> minutes
    let trackName: String?
}

extension TrackModel {
    init(trackData: TrackData) {
        self.artistName = trackData.artistName
        self.trackName = trackData.trackName
        self.artistId = nil
        self.artworkUrl100 = trackData.imageURL
        self.previewUrl = trackData.trackURL
        self.trackTimeMillis = nil
    }
}
