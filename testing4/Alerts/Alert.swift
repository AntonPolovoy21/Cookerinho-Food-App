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
        title: Text("Ошибка недопустимого URL"),
        message: Text("Ошибка сервера"),
        dismissButton: .default(Text("OK"))
    )
    
    static let invalidResponse = AlertItem(
        title: Text("Ошибка. Недопустимый ответ"),
        message: Text("Произошла ошибка"),
        dismissButton: .default(Text("OK"))
    )
    
    static let invalidData = AlertItem(
        title: Text("Ошибка. Недопустимые данные"),
        message: Text("Ошибка сервера"),
        dismissButton: .default(Text("OK"))
    )
    
    static let unableToComplete = AlertItem(
        title: Text("Ошибка не может быть завершена"),
        message: Text("Проверьте подключение к WiFi"),
        dismissButton: .default(Text("OK"))
    )
    
    // MARK:  Account Alerts
    
    static let emptyFields = AlertItem(
        title: Text("Ошибка ввода"),
        message: Text("Не все поля заполнены"),
        dismissButton: .default(Text("OK"))
    )
    
    static let invalidEmail = AlertItem(
        title: Text("Ошибка ввода"),
        message: Text("Неправильный ввод электронной почты"),
        dismissButton: .default(Text("OK"))
    )
    
    // MARK:  Save User Data Alerts
    
    static let unableToSave = AlertItem(
        title: Text("Ошибка сохранения"),
        message: Text("Произошла ошибка при сохранении данных"),
        dismissButton: .default(Text("OK"))
    )
    
    static let saveSuccess = AlertItem(
        title: Text("Профиль сохранен"),
        message: Text("Данные вашего профиля были успешно сохранены!"),
        dismissButton: .default(Text("OK"))
    )
    
    // MARK:  Load User Data Alerts
    
    static let invalidUserData = AlertItem(
        title: Text("Ошибка при загрузке данных"),
        message: Text("Произошла ошибка при загрузке вашей личной информации"),
        dismissButton: .default(Text("OK"))
    )
}
