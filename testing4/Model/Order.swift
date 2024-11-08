//
//  Order.swift
//  testing4
//
//  Created by Anton Polovoy on 9.11.24.
//

import Foundation

final class Order: ObservableObject {
    
    @Published var orderItems: [Dish] = []
    
    var orderPrice: Double {
        orderItems.map({$0.price}).reduce(0, +)
    }
    
    func add(_ dish: Dish) {
        orderItems.append(dish)
    }
    
    func remove(_ index: IndexSet) {
        orderItems.remove(atOffsets: index)
    }
}
