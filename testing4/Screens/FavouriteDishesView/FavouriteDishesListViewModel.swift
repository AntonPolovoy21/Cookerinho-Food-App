//
//  FavouriteDishesListViewModel.swift
//  testing4
//
//  Created by Alex Polovoy on 31.03.25.
//

import SwiftUI

@MainActor final class FavouriteDishesListViewModel: ObservableObject {
    @Published var isShowingDetail = false
    @Published var selectedFavouriteDish: Dish?
    @Published var favouriteDishesList: [Dish] = []
    
    func add(_ dish: Dish) {
        FavoritesManager.shared.saveDish(withId: dish.id)
        favouriteDishesList.append(dish)
    }
    
    func remove(_ index: IndexSet) {
        index.forEach { index in
            let dish = favouriteDishesList[index]
            
            FavoritesManager.shared.deleteDish(withId: dish.id)
            
            favouriteDishesList.remove(at: index)
        }
    }
}
