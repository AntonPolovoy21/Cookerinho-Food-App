//
//  NetworkManager.swift
//  testing4
//
//  Created by Admin on 3.11.23.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let URL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/appetizers"
    
    private init() {}
    
    func getAppetizers (completed: @escaping (Result<[Dish], MyError>) -> Void)  {
        guard let url = Foundation.URL(string: URL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
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
                let decoded = try decoder.decode(DishesRequest.self, from: data)
                completed(.success(decoded.request))
            }
            catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
