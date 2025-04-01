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
            if let error = error { return }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
        }
        
        task.resume()
    }
    
}
