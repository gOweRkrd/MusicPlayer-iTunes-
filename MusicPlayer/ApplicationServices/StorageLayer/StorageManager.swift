//
//  StorageManager.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 20.01.2023.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    private var trackData = [TrackData]()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TrackCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    @discardableResult
    func fetchItems() -> [TrackModel] {
        let fetchRequest = TrackData.fetchRequest()
        do {
            let trackList = try viewContext.fetch(fetchRequest)
            trackData = trackList
            return trackList.map { TrackModel(trackData: $0) }
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveTrack(_ track: TrackModel) {
        if hasModel(track) {
            return
        }
        let item = createItem(from: track)
        viewContext.insert(item)
        saveContext()
        fetchItems()
    }
    
    func delete(_ trackModel: TrackModel) {
        guard let track = trackData.first(where: {$0.trackURL == trackModel.previewUrl}) else {
            return
        }
        viewContext.delete(track)
        saveContext()
        fetchItems()
    }
    
    func hasModel(_ trackModel: TrackModel) -> Bool {
        trackData.first(where: {$0.trackURL == trackModel.previewUrl}) != nil
    }
    
    private func createItem(from trackModel: TrackModel) -> TrackData {
        let track = TrackData(context: viewContext)
        track.artistName = trackModel.artistName
        track.trackName = trackModel.trackName
        track.imageURL = trackModel.artworkUrl100
        track.trackURL = trackModel.previewUrl
        return track
    }
    
    // MARK: - Core Data Saving support
    private func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
