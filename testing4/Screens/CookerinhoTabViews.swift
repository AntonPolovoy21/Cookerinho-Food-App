//
//  ContentView.swift
//  testing4
//
//  Created by Anton Polovoy on 2.11.24.
//

import SwiftUI

struct CookerinhoTabViews: View {
    
    @EnvironmentObject var order: Order
    
    var body: some View {
        TabView {
            DishListView()
                .tabItem {
                    Label("Menu",
                          systemImage: "house"
                    )
                }
            AccountView()
                .tabItem {
                    Label("Account",
                          systemImage: "person.circle"
                    )
                }
            OrderView()
                .tabItem {
                    Label("Order",
                          systemImage: "list.bullet.clipboard"
                    )
                }
                .badge(order.orderItems.count)
        }
    }
}

#Preview {
    CookerinhoTabViews()
}
