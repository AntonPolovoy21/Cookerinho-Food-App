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
    
    @State private var isPasswordVisible = false
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            HStack {
                Text(self.isName ? "Name" : self.isSurname ? "Surname" : self.isEmail ? "Email" : "Password")
                    .foregroundColor(Color.black.opacity(0.5))
                    .onChange(of: value) { newValue in
                        if self.isEmail {
                            value = newValue.lowercased()
                        }
                    }
                
                Spacer()
            }
            
            HStack {
                if self.isEmail || self.isName || self.isSurname {
                    TextField("", text: self.$value)
                    
                } else {
                    if isPasswordVisible {
                        TextField("", text: self.$value)
                            .autocorrectionDisabled()
                    } else {
                        SecureField("", text: self.$value)
                            .autocorrectionDisabled()
                    }
                }
                
                if self.isEmail || self.isName || self.isSurname {
                    Image(systemName: self.isName ? "pencil" : self.isSurname ? "pencil" : self.isEmail ? "envelope.fill" : "eye.slash.fill").foregroundColor(Color("Color1"))
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
