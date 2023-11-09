//
//  OrderEmptyStateView.swift
//  testing4
//
//  Created by Admin on 8.11.23.
//

import SwiftUI

struct OrderEmptyStateView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack {
                Image("empty-order")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                Text("You have no items in your order.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .offset(y: -50)
        }
    }
}

#Preview {
    OrderEmptyStateView()
}
