//
//  ForgotPasswordView.swift
//  testing4
//
//  Created by Alex Polovoy on 2.04.25.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView : View {
    
    @State private var email = ""
    
    @Binding var show : Bool
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertType: CustomAlertType = .error
    
    var body : some View{
        
        ZStack{
            
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
                
                VStack(spacing: 30){
                    
                    Text("Сбросить пароль").font(.title).fontWeight(.bold).foregroundStyle(.black)
                    
                    Text("Введите адрес почты на которую будет отправлено письмо с восстановлением ").fontWeight(.semibold).foregroundStyle(.gray)
                    
                    CustomTF(value: self.$email, isEmail: true)
                    
                    Button(action: {
                        sendPasswordReset()
                    }) {
                        
                        Text("Получить письмо")
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .padding(.vertical)
                            .foregroundColor(.white)
                        
                    }
                    .background(Color("Color1"))
                    .clipShape(Capsule())
                    .padding(.top, 40)
                }
                .padding(.top, 100)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                .padding()
                
                Spacer(minLength: 0)
                
            }
            .edgesIgnoringSafeArea(.top)
            .background(Color("Color")
                .edgesIgnoringSafeArea(.all))
            .overlay(alignment: .topLeading) {
                Button(action: {
                    self.show.toggle()
                }) {
                    
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 30, height: 25)
                        .foregroundColor(.orange)
                    
                }
                .padding(20)
            }
            
            CustomAlertView(wrappedState: $showAlert, withDetails: $alertMessage, type: alertType)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func sendPasswordReset() {
        guard !email.isEmpty && email.isValidEmail else {
            withAnimation {
                withAnimation {
                    
                }
                withAnimation {
                    
                }
                alertMessage = "Пожалуйста, введите верный адрес электронной почты"
                showAlert = true
                alertType = .error
            }
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            print(1)
            if let _ = error {
                DispatchQueue.main.async {
                    withAnimation {
                        alertMessage = "Ошибка отправки письма с восстановлением"
                        showAlert = true
                        alertType = .error
                    }
                }
            } else {
                print(2)
                UsersServerManager.searchUser(byEmail: email) { result in
                    print(result)
                    switch result {
                    case .ok:
                        DispatchQueue.main.async {
                            withAnimation {
                                alertMessage = "Письмо для сброса пароля отправлено! Проверьте вашу почту"
                                showAlert = true
                                alertType = .ok
                            }
                        }
                    case .notFound:
                        DispatchQueue.main.async {
                            withAnimation {
                                alertMessage = "Пользователь с данной почтой не был зарегистрирован"
                                showAlert = true
                                alertType = .warning
                            }
                        }
                    case .wifiError:
                        DispatchQueue.main.async {
                            withAnimation {
                                alertMessage = "Ошибка сети"
                                showAlert = true
                                alertType = .error
                            }
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ForgotPasswordView(show: .constant(true))
}
