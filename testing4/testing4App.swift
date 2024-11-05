//
//  testing4App.swift
//  testing4
//
//  Created by Anton Polovoy on 2.11.24.
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
