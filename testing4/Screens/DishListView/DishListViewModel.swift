//
//  DishesListViewModel.swift
//  testing4
//
//  Created by Admin on 3.11.23.
//

import SwiftUI

final class DishListViewModel: ObservableObject {
    
    @Published var dishes: [Dish] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var isShowingDetail = false
    @Published var sellectedDish: Dish?
    
    func getDishes() {
        
        isLoading.toggle()
        
        NetworkManager.shared.getAppetizers { result in
            DispatchQueue.main.async {
                
                self.isLoading.toggle()
                
                switch result {
                case .success(let dishes):
                    self.dishes = dishes
                    
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                        
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                        
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
