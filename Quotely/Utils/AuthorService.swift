import Foundation

struct AuthorService {
    static func fetchAuthors(completion: @escaping (Result<[Author], Error>) -> Void) {
        let urlString = "https://api.syntax-institut.de/authors?key=4UzjsOdF5qmdG5JvPHIns1haM5zujvkp"
        
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
                let authors = try decoder.decode([Author].self, from: data)
                completion(.success(authors))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
