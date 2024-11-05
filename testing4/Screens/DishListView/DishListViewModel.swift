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
    @Published var sellectedDish: Dish?
    
    func getDishes() {
        isLoading = true
        
        Task {
            do {
                dishes = try await NetworkManager.shared.getDishesCall()
                isLoading = false
            }
            catch {
                
                if let thisError = error as? MyError {
                    switch thisError {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
                else {
                    alertItem = AlertContext.invalidResponse
                }
                
                isLoading = true
            }
        }
    }
}
