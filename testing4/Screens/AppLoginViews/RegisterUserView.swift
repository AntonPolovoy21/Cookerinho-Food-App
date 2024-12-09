//
//  RegisterUserView.swift
//  testing4
//
//  Created by Alex Polovoy on 9.12.24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isRegistrationSuccessful: Bool = false

    var body: some View {
        VStack {
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.emailAddress)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                registerUser()
            }) {
                Text("Register")
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

            if isRegistrationSuccessful {
                Text("Registration successful!")
                    .foregroundColor(.green)
            }
        }
        .padding()
    }

    func registerUser() {
        guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }

        guard let url = URL(string: "http://localhost:1111/createUser") else {
            errorMessage = "Invalid URL."
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let userData = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: userData, options: [])
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
                    isRegistrationSuccessful = true
                    errorMessage = nil
                }
            } else {
                DispatchQueue.main.async {
                    errorMessage = "Registration failed! Please try again."
                    isRegistrationSuccessful = false
                }
            }
        }

        task.resume()
    }
}
