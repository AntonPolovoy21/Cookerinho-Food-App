//
//  LoginUserView.swift
//  testing4
//
//  Created by Alex Polovoy on 9.12.24.
//

import SwiftUI

struct LoginView : View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var show = false
    
    @Binding var isLoggedIn: Bool
    @State private var isLoginSuccessful: Bool = false
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body : some View{
        
        ZStack{
            
            NavigationLink(destination: Register(show: self.$show, isRegistrationSuccessful: $isLoggedIn), isActive: self.$show) {
                
                Text("")
            }
            
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
                    
                    Text("Hello").font(.title).fontWeight(.bold).foregroundStyle(.black)
                    
                    Text("Sign Into Your Account").fontWeight(.bold).foregroundStyle(.black)
                    
                    CustomTF(value: self.$email, isEmail: true)
                    
                    CustomTF(value: self.$password, isEmail: false)
                    
                    Button(action: {
                        loginUser()
                    }) {
                        
                        Text("Login")
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .padding(.vertical)
                            .foregroundColor(.white)
                        
                    }.background(Color("Color1"))
                        .clipShape(Capsule())
                    
                }.padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding()
                
                HStack{
                    
                    Text("Don't Have an Account ?")
                    
                    Button(action: {
                        
                        self.show.toggle()
                        
                    }) {
                        
                        Text("Register Now").foregroundColor(Color("Color1"))
                    }
                    
                }.padding(.top)
                
                Spacer(minLength: 0)
                
            }.edgesIgnoringSafeArea(.top)
                .background(Color("Color").edgesIgnoringSafeArea(.all))
            
            CustomAlertView(wrappedState: $showAlert, withDetails: $alertMessage, type: .error)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func loginUser() {
        guard !email.isEmpty, !password.isEmpty else {
            withAnimation {
                withAnimation {
                
            }
            withAnimation {
                
            }
            alertMessage = "Please enter both email and password."
                showAlert = true
            }
            return
        }
        
        guard let url = URL(string: "http://localhost:1111/userLogin") else {
            withAnimation {
                withAnimation {
                
            }
            withAnimation {
                
            }
            alertMessage = "Invalid URL."
                showAlert = true
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let loginData = ["email": email, "password": password]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: loginData, options: [])
        } catch {
            withAnimation {
                withAnimation {
                
            }
            withAnimation {
                
            }
            alertMessage = "Error creating request body."
                showAlert = true
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    withAnimation {
                        withAnimation {
                
            }
            withAnimation {
                
            }
            alertMessage = "Network error: \(error.localizedDescription)"
                        showAlert = true
                    }
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    withAnimation {
                        withAnimation {
                
            }
            withAnimation {
                
            }
            alertMessage = "Invalid response."
                        showAlert = true
                    }
                }
                return
            }
            
            if httpResponse.statusCode == 200 {
                DispatchQueue.main.async {
                    isLoginSuccessful = true
                    isLoggedIn = true
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                }
            } else {
                DispatchQueue.main.async {
                    withAnimation {
                        withAnimation {
                
            }
            withAnimation {
                
            }
            alertMessage = "Login failed! Check your credentials!"
                        showAlert = true
                    }
                }
            }
        }
        
        task.resume()
    }
}
