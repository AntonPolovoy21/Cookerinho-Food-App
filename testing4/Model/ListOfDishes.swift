//
//  ListOfDishes.swift
//  testing4
//
//  Created by Alex Polovoy on 31.03.25.
//
import Foundation

final class ListOfDishes: ObservableObject {
    @Published var dishesItems: [Dish] = []
}
