//
//  LoginUserView.swift
//  testing4
//
//  Created by Alex Polovoy on 9.12.24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var isLoggedIn: Bool
    
    @State private var errorMessage: String?
    @State private var isLoginSuccessful: Bool = false
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                loginUser()
            }) {
                Text("Login")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            if isLoginSuccessful {
                Text("Login successful!")
                    .foregroundColor(.green)
            }
            
            // Registration Button
            NavigationLink(destination: RegistrationView()) {
                Text("Register")
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .padding()
    }
    
    func loginUser() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter both email and password."
            return
        }
        
        guard let url = URL(string: "http://localhost:1111/userLogin") else {
            errorMessage = "Invalid URL."
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginData = ["email": email, "password": password]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: loginData, options: [])
        } catch {
            errorMessage = "Error creating request body."
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Network error: \(error.localizedDescription)"
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    errorMessage = "Invalid response."
                }
                return
            }
            
            if httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    isLoginSuccessful = true
                    errorMessage = nil
                    isLoggedIn = true // Update the logged-in state
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn") // Save to UserDefaults
                }
            } else {
                DispatchQueue.main.async {
                    errorMessage = "Login failed! Check your credentials!"
                    isLoginSuccessful = false
                }
            }
        }
        
        task.resume()
    }
}
