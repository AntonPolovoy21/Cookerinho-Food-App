//
//  FavouritesManager.swift
//  testing4
//
//  Created by Alex Polovoy on 31.03.25.
//

import Foundation

final class FavouritesManager {
    static let shared = FavouritesManager()
    
    private init() { }
    
    func saveDish(withId id: Int) {
        var favouriteIds = getFavouriteIds()
        
        if !favouriteIds.contains(id) {
            favouriteIds.append(id)
            saveFavouriteIds(favouriteIds)
        }
    }
    
    func deleteDish(withId id: Int) {
        var favouriteIds = getFavouriteIds()
        
        if let index = favouriteIds.firstIndex(of: id) {
            favouriteIds.remove(at: index)
            saveFavouriteIds(favouriteIds)
        }
    }
    
    func getFavouriteIds() -> [Int] {
        if let savedIdsString = UserDefaults.standard.string(forKey: "favouriteDishes") {
            let idsArray = savedIdsString.split(separator: "-").compactMap { Int($0) }
            return idsArray
        }
        return []
    }
    
    private func saveFavouriteIds(_ ids: [Int]) {
        let idsString = ids.map { String($0) }.joined(separator: "-")
        UserDefaults.standard.set(idsString, forKey: "favouriteDishes")
    }
}
