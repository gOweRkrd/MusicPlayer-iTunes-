//
//  ArtistModel.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 18.01.2023.
//

import UIKit

struct ArtistModel {
    let image: UIImage?
    let name: String
    
    static func createArtists() -> [ArtistModel] {
        let adelAlbum = ArtistModel(image: UIImage(named: "adele"),
                                   name: "Adele")
        let theWeeknd = ArtistModel(image: UIImage(named: "theWeekndDawn"),
                                   name: "The Weekend")
        let daftPunk = ArtistModel(image: UIImage(named: "daftPunk"),
                                  name: "Daft Punk")
        let sia = ArtistModel(image: UIImage(named: "sia"),
                             name: "Sia")
        let depecheMode = ArtistModel(image: UIImage(named: "depecheMode"),
                                     name: "Depeche Mode")
        let sting = ArtistModel(image: UIImage(named: "sting"),
                               name: "Sting")
        let imagineDragons = ArtistModel(image: UIImage(named: "imagineDragons"),
                                        name: "Imagine Dragons")
        return [adelAlbum, theWeeknd, daftPunk, sia, depecheMode, sting, imagineDragons]
    }
}
