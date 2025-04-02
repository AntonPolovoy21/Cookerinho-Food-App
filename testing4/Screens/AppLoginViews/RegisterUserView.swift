//
//  RegisterUserView.swift
//  testing4
//
//  Created by Alex Polovoy on 9.12.24.
//

import SwiftUI
import FirebaseAuth

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
                    
                    Text("Приветствуем")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    
                    Text("Создайте Учетную Запись")
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    
                    CustomTF(value: self.$firstName, isName: true)
                    
                    CustomTF(value: self.$lastName, isSurname: true)
                    
                    CustomTF(value: self.$email, isEmail: true)
                    
                    CustomTF(value: self.$password, isEmail: false)
                    
                    Button(action: {
                        registerUser()
                    }) {
                        
                        Text("Зарегистрироваться")
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
                alertMessage = "Пожалуйста, заполните все поля"
                showAlert = true
            }
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    withAnimation {
                        alertMessage = "Ошибка регистрации"
                        showAlert = true
                    }
                }
                return
            }
        }
        
        guard let url = URL(string: "http://localhost:1111/createUser") else {
            withAnimation {
                alertMessage = "Проверьте подключение к WiFi"
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
            "password": password,
            "favorites": ""
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: userData, options: [])
        } catch {
            withAnimation {
                alertMessage = "Проверьте подключение к WiFi"
                showAlert = true
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    withAnimation {
                        alertMessage = "Ошибка сети"
                        showAlert = true
                    }
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    withAnimation {
                        alertMessage = "Неверный ответ сервера"
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
                    
                    UserDefaults.standard.set(email, forKey: "userEmail")
               
                    UserDefaults.standard.set(firstName, forKey: "usersFirstName")
                    UserDefaults.standard.set(lastName, forKey: "usersLastName")
                    
                    UserDefaults.standard.set("", forKey: "favouriteDishes")
                }
            } else {
                DispatchQueue.main.async {
                    withAnimation {
                        alertMessage = "Регистрация не удалась! Пожалуйста, попробуйте еще раз"
                        showAlert = true
                        isRegistrationSuccessful = false
                    }
                }
            }
        }
        
        task.resume()
    }
}
