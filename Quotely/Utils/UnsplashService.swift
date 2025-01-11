//
//  UnsplashService.swift
//  Quotely
//
//  Created by Michael Winkler on 08.01.25.
//

import Foundation

class UnsplashService {
    static let shared = UnsplashService()
    private let accessKey = "OS8wGOltkm_crMqAkidmGPF06U1DZhOg2KK6EANHzqc"
    private let baseURL = "https://api.unsplash.com/photos"
    
    func fetchImages(completion: @escaping (Result<[UnsplashImage], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?client_id=\(accessKey)") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            do {
                let images = try JSONDecoder().decode([UnsplashImage].self, from: data)
                completion(.success(images))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
