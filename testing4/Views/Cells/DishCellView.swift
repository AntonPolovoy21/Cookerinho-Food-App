//
//  DishCellView.swift
//  testing4
//
//  Created by Anton Polovoy on 3.11.24.
//

import SwiftUI

struct DishCellView: View {
    
    let dish: Dish
    
    var body: some View {
        HStack {
            FirebaseImageSmall(id: dish.imageURL)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(dish.name)
                    .font(.title2)
                Text("$\(dish.price, specifier: "%.2f")")
                    .fontWeight(.semibold)
                    .font(.callout)
                    .foregroundStyle(Color.secondary)
            }
            .padding(.leading)
        }
    }
}

#Preview {
    DishCellView(dish: MockData.sampleDish)
}
