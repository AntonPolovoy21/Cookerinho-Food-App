//
//  NetworkManager.swift
//  testing4
//
//  Created by Anton Polovoy on 3.11.24.
//

import Foundation
import FirebaseDatabase
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    private let URL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/appetizers"
    
    private init() {}
    
    func getDishesCall() async throws -> [Dish] {
        guard let url = Foundation.URL(string: URL) else {
            throw MyError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(DishesRequest.self, from: data).request
        }
        catch {
            throw MyError.invalidData
        }
    }
}
