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
}
