//
//  Dish.swift
//  testing4
//
//  Created by Anton Polovoy on 3.11.24.
//

import Foundation

struct Dish: Decodable, Identifiable {
    let price: Double
    let name, description, imageURL: String
    let id, calories, grams: Int
}

struct DishesRequest: Decodable {
    let request: [Dish]
}

struct MockData {
    static let sampleDish = Dish(price: 9.99, name: "Sample Dish", description: "This is the description for my dish. It's yummy.", imageURL: "asian-flank-steak", id: 0, calories: 99, grams: 99)
    
    static let dishes = [sampleDish, sampleDish, sampleDish, sampleDish, sampleDish]
}
