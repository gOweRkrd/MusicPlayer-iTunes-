//
//  NetworkManager.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 17.01.2023.
//

import UIKit
class NetworkManager {

    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func getAllMusic(from country: Country, completed: @escaping (Result<AlbumResult, MusicError>) -> Void) {
        let countryURL = "https://itunes.apple.com/search?country=\(country.rawValue)&term=music"
        guard let url = URL(string: countryURL) else {
            completed(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()

                let result = try decoder.decode(AlbumResult.self, from: data)
                completed(.success(result))
            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }

    func getArtistAlbum(name: String, completed: @escaping (Result<AlbumResult, MusicError>) -> Void) {
        let joinedName = name.replacingOccurrences(of: " ", with: "+")
        let stringURL = "https://itunes.apple.com/search?term=\(joinedName)"

        guard let url = URL(string: stringURL) else {
            completed(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()

                let result = try decoder.decode(AlbumResult.self, from: data)
                completed(.success(result))
            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }

    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }

            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }

        task.resume()
    }
}
