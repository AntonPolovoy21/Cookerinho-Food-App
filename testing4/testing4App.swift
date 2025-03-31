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
    var listOfDishes = ListOfDishes()
    
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if !isLoggedIn {
                    CookerinhoTabViews(isLoggedIn: $isLoggedIn)
                        .environmentObject(listOfDishes)
                        .environmentObject(order)
                } else {
                    LoginView(isLoggedIn: $isLoggedIn)
                }
            }
        }
    }
}
