//
//  CustomTextField.swift
//  testing4
//
//  Created by Alex Polovoy on 12.12.24.
//

import SwiftUI

struct CustomTF: View {
    
    @Binding var value: String
    var isEmail = false
    var isName = false
    var isSurname = false
    var isPhoneNumber = false
    
    @State private var isPasswordVisible = false
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            HStack {
                Text(self.isPhoneNumber ? "Ваш номер телефона" : self.isName ? "Имя" : self.isSurname ? "Фамилия" : self.isEmail ? "Почта" : "Пароль")
                    .foregroundColor(Color.black.opacity(0.5))
                    .onChange(of: value, { _, newValue in
                        if self.isEmail {
                            value = newValue.lowercased()
                        }
                    })
                
                Spacer()
            }
            
            HStack {
                if self.isEmail || self.isName || self.isSurname {
                    TextField("", text: self.$value)
                        .foregroundStyle(.black)
                    
                }
                else if self.isPhoneNumber {
                    TextField("+375 (__) ___ __ __", text: self.$value)
                        .foregroundStyle(.black)
                }
                else {
                    if isPasswordVisible {
                        TextField("", text: self.$value)
                            .autocorrectionDisabled()
                            .foregroundStyle(.black)
                    } else {
                        SecureField("", text: self.$value)
                            .autocorrectionDisabled()
                            .foregroundStyle(.black)
                    }
                }
                
                if self.isPhoneNumber || self.isEmail || self.isName || self.isSurname {
                    Image(systemName: self.isPhoneNumber ? "phone.fill" : self.isName ? "pencil" : self.isSurname ? "pencil" : self.isEmail ? "envelope.fill" : "eye.slash.fill").foregroundColor(Color("Color1"))
                }
                else {
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(Color("Color1"))
                    }
                }
            }
            
            Divider()
        }
    }
}
