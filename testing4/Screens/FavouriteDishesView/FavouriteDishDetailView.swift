//
//  FavouriteDishDetailView.swift
//  testing4
//
//  Created by Alex Polovoy on 31.03.25.
//

import SwiftUI

struct FavouriteDishDetailView: View {
    
    @EnvironmentObject var order: Order
    @State var isFavourite = false
    @Binding var isShowingDetail: Bool
    let dish: Dish
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
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
}

#Preview {
    FavouriteDishDetailView(isShowingDetail: .constant(true),
                   dish: MockData.sampleDish)
}
