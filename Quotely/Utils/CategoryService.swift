//
//  CategoryService.swift
//  Quotely
//
//  Created by Michael Winkler on 10.01.25.
//

import Foundation

class CategoryService {
    static let shared = CategoryService()

    private let baseURL = "https://api.syntax-institut.de/categories"
    
    static func fetchCategoryQuotes(completion: @escaping (Result<[Quote], QuoteServiceError>) -> Void) {
        guard let url = URL(string: "https://api.syntax-institut.de/quotes?limit=999") else {
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
    
    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        let urlString = "\(baseURL)"
        guard let url = URL(string: urlString) else {
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
                let categories = try JSONDecoder().decode([String].self, from: data)
                completion(.success(categories))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
