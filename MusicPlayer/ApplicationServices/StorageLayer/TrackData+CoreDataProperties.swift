//
//  TrackData+CoreDataProperties.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 20.01.2023.
//
//

import Foundation
import CoreData

extension TrackData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackData> {
        return NSFetchRequest<TrackData>(entityName: "TrackData")
    }

    @NSManaged public var artistName: String
    @NSManaged public var trackName: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var trackURL: String?

}

extension TrackData: Identifiable {

}
