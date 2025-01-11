//
//  QuoteService.swift
//  Quotely
//
//  Created by Michael Winkler on 10.01.25.
//

import Foundation

enum QuoteServiceError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct QuoteService {
    func fetchQuotesByAuthor(authorId: String, completion: @escaping (Result<[Quote], Error>) -> Void) {
        let urlString = "https://api.syntax-institut.de/quotes?author_id=\(authorId)&key=4UzjsOdF5qmdG5JvPHIns1haM5zujvkp&limit=999"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let quotes = try decoder.decode([Quote].self, from: data)
                completion(.success(quotes))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    static func fetchQuotes(completion: @escaping (Result<[Quote], QuoteServiceError>) -> Void) {
        guard let url = URL(string: "https://api.syntax-institut.de/quotes") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                completion(.success(quotes))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
