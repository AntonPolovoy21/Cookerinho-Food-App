//
//  DishesListViewModel.swift
//  testing4
//
//  Created by Anton Polovoy on 3.11.24.
//

import SwiftUI

@MainActor final class DishListViewModel: ObservableObject {
    @Published var dishes: [Dish] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var isShowingDetail = false
    @Published var selectedDish: Dish?
}
