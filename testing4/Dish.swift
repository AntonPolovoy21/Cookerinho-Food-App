//
//  Dish.swift
//  testing4
//
//  Created by Admin on 3.11.23.
//

import Foundation

struct Dish: Decodable, Identifiable {
    let price: Double
    let name, description, imageURL: String
    let id, calories, carbs, protein: Int
}

struct DishesRequest: Decodable {
    let request: [Dish]
}

struct MockData {
    static let sampleDish = Dish(price: 9.99, name: "Sample Dish", description: "Umm yummy!!!", imageURL: "asian-flank-steak", id: 0, calories: 99, carbs: 99, protein: 99)
    
    static let dishes = [sampleDish, sampleDish, sampleDish, sampleDish, sampleDish]
}
