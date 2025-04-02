//
//  LoginUserView.swift
//  testing4
//
//  Created by Alex Polovoy on 9.12.24.
//

import SwiftUI
import FirebaseAuth

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
                    
                    Text("Приветствуем").font(.title).fontWeight(.bold).foregroundStyle(.black)
                    
                    Text("Войдите В Свою Учетную Запись").fontWeight(.bold).foregroundStyle(.black)
                    
                    CustomTF(value: self.$email, isEmail: true)
                    
                    CustomTF(value: self.$password, isEmail: false)
                    
                    Button(action: {
                        loginUser()
                    }) {
                        
                        Text("Вход в систему")
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
                    
                    Text("У вас нет аккаунта?")
                    
                    Button(action: {
                        
                        self.show.toggle()
                        
                    }) {
                        
                        Text("Зарегистрироваться").foregroundColor(Color("Color1"))
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
                alertMessage = "Пожалуйста, введите электронную почту и пароль"
                showAlert = true
            }
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    withAnimation {
                        alertMessage = "Ошибка входа. Неверный логин или пароль"
                        showAlert = true
                    }
                }
                return
            }
        }
        
        guard let url = URL(string: "http://localhost:1111/userLogin") else {
            withAnimation {
                withAnimation {
                    
                }
                withAnimation {
                    
                }
                alertMessage = "Проверьте подключение к WiFi"
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
                alertMessage = "Проверьте подключение к WiFi"
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
                        alertMessage = "Ошибка сети: \(error.localizedDescription)"
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
                        alertMessage = "Неверный ответ сервера"
                        showAlert = true
                    }
                }
                return
            }
            
            if httpResponse.statusCode == 200 {
                guard let data = data else {
                    DispatchQueue.main.async {
                        withAnimation {
                            alertMessage = "Нет данных от сервера"
                            showAlert = true
                        }
                    }
                    return
                }
                
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let user = jsonResponse["user"] as? [String: Any],
                       let firstName = user["firstName"] as? String,
                       let lastName = user["lastName"] as? String,
                       let email = user["email"] as? String ,
                       let favorites = user["favorites"] as? String {
                        
                        DispatchQueue.main.async {
                            isLoginSuccessful = true
                            isLoggedIn = true
                            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                            
                            UserDefaults.standard.set(email, forKey: "userEmail")
                            
                            UserDefaults.standard.set(firstName, forKey: "usersFirstName")
                            UserDefaults.standard.set(lastName, forKey: "usersLastName")
                            
                            UserDefaults.standard.set(favorites, forKey: "favouriteDishes")
                        }
                    } else {
                        DispatchQueue.main.async {
                            withAnimation {
                                alertMessage = "Ошибка при обработке ответа сервера"
                                showAlert = true
                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        withAnimation {
                            alertMessage = "Ошибка при обработке ответа сервера"
                            showAlert = true
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    withAnimation {
                        withAnimation {
                            
                        }
                        withAnimation {
                            
                        }
                        alertMessage = "Вход в систему не удался! Проверьте свои учетные данные!"
                        showAlert = true
                    }
                }
            }
        }
        
        task.resume()
    }
}
