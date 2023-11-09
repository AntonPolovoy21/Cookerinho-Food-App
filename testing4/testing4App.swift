//
//  testing4App.swift
//  testing4
//
//  Created by Admin on 2.11.23.
//

import SwiftUI

@main
struct testing4App: App {
    
    var order = Order()
    
    var body: some Scene {
        WindowGroup {
            CookerinhoTabViews().environmentObject(order)
        }
    }
}
