//
//  FirebaseFactory.swift
//  testing4
//
//  Created by Alex Polovoy on 28.03.25.
//

import FirebaseDatabase

class FirebaseFactory {
    private var ref: DatabaseReference = Database.database().reference()
    
    func fetchDishes(completion: @escaping ([Dish]) -> Void) {
        ref.child("dishes").observeSingleEvent(of: .value) { snapshot  in
            
            var dishes: [Dish] = []

            if let value = snapshot.value as? [String: [String: Any]] {
                for (_, some) in value {
                    if let price = some["price"] as? Double,
                       let name = some["name"] as? String,
                       let description = some["description"] as? String,
                       let imageURL = some["imageURL"] as? String,
                       let id = some["id"] as? Int,
                       let calories = some["calories"] as? Int,
                       let carbs = some["carbs"] as? Int,
                       let protein = some["protein"] as? Int
                    {
                        let dish = Dish(price: price,
                                        name: name,
                                        description: description,
                                        imageURL: imageURL,
                                        id: id,
                                        calories: calories,
                                        carbs: carbs,
                                        protein: protein)
                        dishes.append(dish)
                    }
                }
            }
            
            completion(dishes.sorted { $0.id < $1.id })
        }
    }
}
