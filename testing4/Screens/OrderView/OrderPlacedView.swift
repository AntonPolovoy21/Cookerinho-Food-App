//
//  OrderPlacedView.swift
//  testing4
//
//  Created by Alex Polovoy on 4.04.25.
//

import SwiftUI

struct OrderPlacedView: View {
    @Binding var wasOrderPlaced: Bool
    
    var body: some View {
        VStack {
            
            VStack(spacing: 30){
                CustomIndicatorView(type: .warning)
                
                Text("Ваш заказ отправлен на обработку!")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                
                Text("На этой странице вы можете отслеживать статус вашего заказа. Статус изменится как только ресторан примет ваш заказ")
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    wasOrderPlaced = false
                    UserDefaults.standard.set(false, forKey: "wasOrderPlaced")
                }) {
                    
                    Text("Отменить заказ")
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .padding(.vertical)
                        .foregroundColor(.white)
                    
                }
                .background(.red)
                .clipShape(Capsule())
                .padding(.top, 40)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color.white)
            .ignoresSafeArea()
        }
    }
}


#Preview {
    OrderPlacedView(wasOrderPlaced: .constant(true))
}
