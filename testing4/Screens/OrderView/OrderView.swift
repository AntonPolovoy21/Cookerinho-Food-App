//
//  OrderView.swift
//  testing4
//
//  Created by Anton Polovoy on 2.11.24.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var order: Order
    @EnvironmentObject var listOfDishes: ListOfDishes
    
    @State private var showConfirmation = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(order.orderItems) { item in
                            DishCellView(dish: item)
                        }
                        .onDelete {
                            order.remove($0)
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    Button {
                        showConfirmation = true
                    } label: {
                        MyButtonView(title: "\(order.orderPrice, specifier: "%.2f Br") - Сделать заказ")
                    }
                    .padding()
                }
                .task {
                    loadOrder()
                }
                
                if order.orderItems.isEmpty {
                    OrderEmptyStateView()
                }
                
            }
            .navigationTitle("🧾 Заказ")
            .sheet(isPresented: $showConfirmation) {
                ConfirmationView(isPresented: $showConfirmation)
            }
        }
    }
    
    private func loadOrder() {
        if let savedIdsString = UserDefaults.standard.string(forKey: "orderString") {
            
            let idsArray = savedIdsString.split(separator: "-").compactMap { Int($0) }
            
            DispatchQueue.main.async {
                self.order.orderItems.removeAll()
                UserDefaults.standard.set("", forKey: "orderString")
                
                for myId in idsArray {
                    if let dish = listOfDishes.dishesItems.first(where: { $0.id == myId }) {
                        self.order.add(dish)
                    }
                }
            }
        } else {
            self.order.orderItems = []
        }
    }
}

#Preview {
    OrderView()
}
