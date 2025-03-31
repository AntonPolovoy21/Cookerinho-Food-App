//
//  MenuView.swift
//  testing4
//
//  Created by Anton Polovoy on 2.11.24.
//

import SwiftUI

struct DishListView: View {
    
    @StateObject private var viewModel = DishListViewModel()
    @EnvironmentObject var listOfDishes: ListOfDishes
    
    var body: some View {
        ZStack {
            NavigationView{
                List {
                    ForEach(viewModel.dishes) { dish in
                        DishCellView(dish: dish)
                            .listRowSeparator(.visible)
                            .onTapGesture {
                                viewModel.selectedDish = dish
                                viewModel.isShowingDetail.toggle()
                            }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("🥥 Cookerinho")
                .disabled(viewModel.isShowingDetail)
            }
            .blur(radius: (viewModel.isShowingDetail ? 10 : 0))
            .task {
                getDishes()
            }
            .focusedObject(self.listOfDishes)
            if viewModel.isShowingDetail {
                DishDetailView(isShowingDetail: $viewModel.isShowingDetail,
                               dish: viewModel.selectedDish ?? MockData.sampleDish)
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
    
    private func getDishes() {
        if !listOfDishes.dishesItems.isEmpty { return }
        viewModel.isLoading = true
        
        Task {
            do {
                let firebaseFactory = FirebaseFactory()
                firebaseFactory.fetchDishes { dishesFromDB in
                    self.listOfDishes.dishesItems = dishesFromDB
                    self.viewModel.dishes = dishesFromDB
                    self.viewModel.isLoading = false
                }
            }
        }
    }
}

#Preview {
    DishListView()
}
