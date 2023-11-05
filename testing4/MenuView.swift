//
//  MenuView.swift
//  testing4
//
//  Created by Admin on 2.11.23.
//

import SwiftUI

struct MenuView: View {
    
    @StateObject private var viewModel = DishListViewModel()
    
    var body: some View {
        ZStack {
            NavigationView{
                List {
                    ForEach(viewModel.dishes) { dish in
                        DishCellView(dish: dish)
                            .listRowSeparator(.visible)
                    }
                }
                .listStyle(.grouped)
                .navigationTitle("🥥 Cookerinho")
            }
            .onAppear {
                viewModel.getDishes()
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    MenuView()
}
