//
//  ContentView.swift
//  testing4
//
//  Created by Admin on 2.11.23.
//

import SwiftUI

struct CookerinhoTabViews: View {
    var body: some View {
        TabView {
           MenuView()
                .tabItem {
                    Label("Menu",
                          systemImage: "house")
                }

            AccountView()
                 .tabItem {
                     Label("Account",
                           systemImage: "person.circle")
                 }
            
            OrderView()
                 .tabItem {
                     Label("Order",
                           systemImage: "list.bullet.clipboard")
                 }
        }
    }
}

#Preview {
    CookerinhoTabViews()
}
