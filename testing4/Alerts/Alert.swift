//
//  Alert.swift
//  testing4
//
//  Created by Admin on 5.11.23.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    //MARK:  Network Alerts
    static let invalidURL       = AlertItem(title: Text("Error invalid URL"),
                                            message: Text("There was an error"),
                                            dismissButton: .default(Text("OK")))
    
    static let invalidResponse  = AlertItem(title: Text("Error invalid response"),
                                            message: Text("There was an error"),
                                            dismissButton: .default(Text("OK")))
    
    static let invalidData      = AlertItem(title: Text("Error invalid data"),
                                            message: Text("There was an error"),
                                            dismissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(title: Text("Error unable to complete"),
                                            message: Text("There was an error"),
                                            dismissButton: .default(Text("OK")))
    
    //MARK:  Account Alerts
    static let emptyFields      = AlertItem(title: Text("Input error"),
                                            message: Text("Not all fields are filled in"),
                                            dismissButton: .default(Text("OK")))
    
    static let invalidEmail     = AlertItem(title: Text("Input error"),
                                            message: Text("Incorrect email input"),
                                            dismissButton: .default(Text("OK")))
}
