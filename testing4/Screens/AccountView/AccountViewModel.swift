//
//  AccountViewModel.swift
//  testing4
//
//  Created by Admin on 6.11.23.
//

import SwiftUI

final class AccountViewModel: ObservableObject {
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var birthDate = Date()
    @Published var isExtraNapkins = false
    @Published var frequentRefills = false
    
    @Published var alertItem: AlertItem?
    
    var isValidForm:Bool {
        guard !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty else { 
            alertItem = AlertContext.emptyFields
            return false
        }
        
        guard email.isValidEmail else {
            alertItem = AlertContext.invalidEmail
            return false
        }
        
        return true
    }
    
    func saveChanges() {
        guard isValidForm else { return }
        
        print("Saved changes")
    }
}
