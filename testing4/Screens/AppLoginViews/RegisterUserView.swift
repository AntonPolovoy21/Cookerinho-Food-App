//
//  RegisterUserView.swift
//  testing4
//
//  Created by Alex Polovoy on 9.12.24.
//

import SwiftUI

struct Register : View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    
    @Binding var show : Bool
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @Binding var isRegistrationSuccessful: Bool
    
    var body : some View{
        
        ZStack(alignment: .topLeading) {
            
            VStack{
                
                HStack{
                    
                    Spacer()
                    
                    Image("shape")
                    
                }
                
                VStack{
                    
                    Image("logo")
                    Text("Cookerinho")
                        .font(.system(size: 20, weight: .regular, design: .monospaced))
                    
                }.offset(y: -122)
                    .padding(.bottom,-132)
                
                VStack(spacing: 20){
                    
                    Text("Hello").font(.title).fontWeight(.bold)
                    
                    Text("Create an account").fontWeight(.bold)
                    
                    CustomTF(value: self.$firstName, isName: true)
                    
                    CustomTF(value: self.$lastName, isSurname: true)
                    
                    CustomTF(value: self.$email, isEmail: true)
                    
                    CustomTF(value: self.$password, isEmail: false)
                    
                    Button(action: {
                        registerUser()
                    }) {
                        
                        Text("Register Now")
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .padding(.vertical)
                            .foregroundColor(.white)
                        
                    }.background(Color("Color1"))
                        .clipShape(Capsule())
                    
                }.padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding()
                
                
                Spacer(minLength: 0)
                
            }.edgesIgnoringSafeArea(.top)
                .background(Color("Color").edgesIgnoringSafeArea(.all))
            
            Button(action: {
                
                self.show.toggle()
                
            }) {
                
                Image(systemName: "arrow.left").resizable().frame(width: 30, height: 25).foregroundColor(.orange)
                
            }.padding(20)
            
            CustomAlertView(wrappedState: $showAlert, withDetails: $alertMessage, type: .error)
        }.navigationBarTitle("")
            .navigationBarHidden(true)
        
    }
    
    func registerUser() {
        guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty else {
            withAnimation {
                alertMessage = "Please fill in all fields."
                showAlert = true
            }
            return
        }
        
        guard let url = URL(string: "http://localhost:1111/createUser") else {
            withAnimation {
                alertMessage = "Invalid URL."
                showAlert = true
            }
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
            withAnimation {
                alertMessage = "Error creating request body."
                showAlert = true
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    withAnimation {
                        alertMessage = "Network error: \(error.localizedDescription)"
                        showAlert = true
                    }
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    withAnimation {
                        alertMessage = "Invalid response."
                        showAlert = true
                    }
                }
                return
            }
            
            if httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    isRegistrationSuccessful = true
                    alertMessage = ""
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                }
            } else {
                DispatchQueue.main.async {
                    withAnimation {
                        alertMessage = "Registration failed! Please try again."
                        showAlert = true
                        isRegistrationSuccessful = false
                    }
                }
            }
        }
        
        task.resume()
    }
}
