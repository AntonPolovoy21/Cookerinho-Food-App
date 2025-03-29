//
//  DishDetailView.swift
//  testing4
//
//  Created by Anton Polovoy on 6.11.24.
//

import SwiftUI

struct DishDetailView: View {
    
    @EnvironmentObject var order: Order
    
    @Binding var isShowingDetail: Bool
    let dish: Dish
    
    var body: some View {
        VStack {
            FirebaseImageWide(id: dish.imageURL)
            
            VStack {
                Text(dish.name)
                    .bold()
                    .font(.title2)
                Text(dish.description)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.gray)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                HStack(spacing: 40) {
                    DishStatView(name: "Калорий",
                                 amount: "\(dish.calories)")
                    DishStatView(name: "Масса",
                                 amount: "\(dish.grams) г")
                }
            }
            Spacer()
            Button {
                isShowingDetail.toggle()
                order.add(dish)
            } label: {
                MyButtonView(title: "\(dish.price, specifier: "%.2f Br") - Добавить к заказу")
            }
            Spacer()
        }
        .frame(width: 320, height: 525)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(alignment: .topTrailing) {
            Button{
                isShowingDetail.toggle()
            } label: {
                XDismissButton()
            }
        }
    }
}

#Preview {
    DishDetailView(isShowingDetail: .constant(true),
                   dish: MockData.sampleDish)
}

struct DishStatView: View {
    
    let name: String
    let amount: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(name)
                .font(.callout)
            Text(amount)
                .italic()
                .foregroundStyle(Color.gray)
                .font(.headline)
        }
    }
}
