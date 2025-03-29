//
//  ContentView.swift
//  testing4
//
//  Created by Anton Polovoy on 2.11.24.
//

import SwiftUI

struct CookerinhoTabViews: View {
    
    @EnvironmentObject var order: Order
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        TabView {
            DishListView()
                .tabItem {
                    Label("Меню",
                          systemImage: "house"
                    )
                }
            AccountView()
                .tabItem {
                    Label("Профиль",
                          systemImage: "person.circle"
                    )
                }
                .overlay(alignment: .topTrailing) {
                    Button{
                        isLoggedIn = false
                        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                        print(2323)
                    } label: {
                        XLogOutButton()
                            .padding()
                    }
                }
            OrderView()
                .tabItem {
                    Label("Заказ",
                          systemImage: "list.bullet.clipboard"
                    )
                }
                .badge(order.orderItems.count)
        }
    }
}

#Preview {
    CookerinhoTabViews(isLoggedIn: .constant(true))
        .environmentObject(Order())
}
