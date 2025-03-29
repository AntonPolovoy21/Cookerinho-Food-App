//
//  testing4App.swift
//  testing4
//
//  Created by Anton Polovoy on 2.11.24.
//

import SwiftUI

@main
struct Testing4App: App {
    
    var order = Order()
    
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if !isLoggedIn {
                    CookerinhoTabViews(isLoggedIn: $isLoggedIn).environmentObject(order)
                } else {
                    LoginView(isLoggedIn: $isLoggedIn)
                }
            }
        }
    }
}
