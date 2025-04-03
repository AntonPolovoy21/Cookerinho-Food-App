//
//  NetworkManager.swift
//  testing4
//
//  Created by Anton Polovoy on 3.11.24.
//

import Foundation
import FirebaseDatabase
import UIKit

struct UsersServerManager {
    
    static func updateUserName(withFirstName first: String, withLastName last: String) {
        guard let url = URL(string: "http://localhost:1111/updateUser") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let email = UserDefaults.standard.string(forKey: "userEmail") else { return }
        
        let userData = [
            "email": email,
            "firstName": first,
            "lastName": last
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: userData, options: [])
        } catch { return }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil { return }
            
            guard response is HTTPURLResponse else { return }
        }
        
        task.resume()
    }
    
    static func updateUserFavorites(withFavorites favorites: String) {
        guard let url = URL(string: "http://localhost:1111/updateUserFavorites") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let email = UserDefaults.standard.string(forKey: "userEmail") else { return }
        
        let userData = [
            "email": email,
            "favorites": favorites,
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: userData, options: [])
        } catch { return }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil { return }
            
            guard response is HTTPURLResponse else { return }
        }
        
        task.resume()
    }
    
    static func searchUser(byEmail email: String, completion: @escaping (SearchUserResultType) -> Void) {
        guard let url = URL(string: "http://localhost:1111/searchUser") else {
            completion(.wifiError)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let searchData = ["email": email]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: searchData, options: [])
        } catch {
            completion(.wifiError)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.wifiError)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.wifiError)
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(.ok)
            } else {
                completion(.notFound)
            }
        }
        
        task.resume()
    }
}
