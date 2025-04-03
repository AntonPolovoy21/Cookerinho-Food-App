//
//  Order.swift
//  testing4
//
//  Created by Anton Polovoy on 9.11.24.
//

import Foundation

final class Order: ObservableObject {
    
    @Published var orderItems: [Dish] = []
    
    init() {
        for _ in getOrderIds() {
            orderItems.append(MockData.sampleDish)
        }
    }
    
    var orderPrice: Double {
        orderItems.map({ $0.price }).reduce(0, +)
    }
    
    func add(_ dish: Dish) {
        saveDish(withId: dish.id)
        orderItems.append(dish)
    }
    
    func remove(_ index: IndexSet) {
        index.forEach { index in
            let dish = orderItems[index]
            deleteDish(withId: dish.id)
            orderItems.remove(at: index)
        }
    }
    
    func saveDish(withId id: Int) {
        var favouriteIds = getOrderIds()
        
        favouriteIds.append(id)
        saveOrderIds(favouriteIds)
    }
    
    func deleteDish(withId id: Int) {
        var favouriteIds = getOrderIds()
        
        if let index = favouriteIds.firstIndex(of: id) {
            favouriteIds.remove(at: index)
            saveOrderIds(favouriteIds)
        }
    }
    
    func getOrderIds() -> [Int] {
        if let savedIdsString = UserDefaults.standard.string(forKey: "orderString") {
            let idsArray = savedIdsString.split(separator: "-").compactMap { Int($0) }
            return idsArray
        }
        return []
    }
    
    private func saveOrderIds(_ ids: [Int]) {
        let idsString = ids.map { String($0) }.joined(separator: "-")
        UserDefaults.standard.set(idsString, forKey: "orderString")
        
        UsersServerManager.updateUserFavorites(withFavorites: idsString)
    }
}
