//
//  Alert.swift
//  testing4
//
//  Created by Anton Polovoy on 5.11.24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    // MARK:  Network Alerts
    
    static let invalidURL = AlertItem(
        title: Text("Error invalid URL"),
        message: Text("Server error"),
        dismissButton: .default(Text("OK"))
    )
    
    static let invalidResponse = AlertItem(
        title: Text("Error invalid response"),
        message: Text("There was an error"),
        dismissButton: .default(Text("OK"))
    )
    
    static let invalidData = AlertItem(
        title: Text("Error invalid data"),
        message: Text("Server error"),
        dismissButton: .default(Text("OK"))
    )
    
    static let unableToComplete = AlertItem(
        title: Text("Error unable to complete"),
        message: Text("Check WiFi connection"),
        dismissButton: .default(Text("OK"))
    )
    
    // MARK:  Account Alerts
    
    static let emptyFields = AlertItem(
        title: Text("Input error"),
        message: Text("Not all fields are filled in"),
        dismissButton: .default(Text("OK"))
    )
    
    static let invalidEmail = AlertItem(
        title: Text("Input error"),
        message: Text("Incorrect email input"),
        dismissButton: .default(Text("OK"))
    )
    
    // MARK:  Save User Data Alerts
    
    static let unableToSave = AlertItem(
        title: Text("Error saving data"),
        message: Text("Error was occured saving your data"),
        dismissButton: .default(Text("OK"))
    )
    
    static let saveSuccess = AlertItem(
        title: Text("Profile saved"),
        message: Text("Your profile data was successfully saved!"),
        dismissButton: .default(Text("OK"))
    )
    
    // MARK:  Load User Data Alerts
    
    static let invalidUserData = AlertItem(
        title: Text("Error loading data"),
        message: Text("Error was occured loading your personal information"),
        dismissButton: .default(Text("OK"))
    )
}
