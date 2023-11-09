//
//  OrderView.swift
//  testing4
//
//  Created by Admin on 2.11.23.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var order: Order
    
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
                        
                    } label: {
                        MyButtonView(title: "$\(order.orderPrice, specifier: "%.2f") - Place Order")
                    }
                    .padding()
                }
                
                if order.orderItems.isEmpty {
                    OrderEmptyStateView()
                }
                
            }
            .navigationTitle("🧾 Order")
        }
    }
}

#Preview {
    OrderView()
}
