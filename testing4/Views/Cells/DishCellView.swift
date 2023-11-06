//
//  DishCellView.swift
//  testing4
//
//  Created by Admin on 3.11.23.
//

import SwiftUI

struct DishCellView: View {
    
    let dish: Dish
    
    var body: some View {
        HStack {
            CookerinhoRemoteImage(urlString: dish.imageURL)
                .scaledToFit()
                .frame(width: 120, height: 90)
                .cornerRadius(8)
            
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
