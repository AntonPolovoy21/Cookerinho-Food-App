//
//  MenuView.swift
//  testing4
//
//  Created by Admin on 2.11.23.
//

import SwiftUI

struct DishListView: View {
    
    @StateObject private var viewModel = DishListViewModel()
    
    var body: some View {
        ZStack {
            NavigationView{
                List {
                    ForEach(viewModel.dishes) { dish in
                        DishCellView(dish: dish)
                            .listRowSeparator(.visible)
                            .onTapGesture {
                                viewModel.sellectedDish = dish
                                viewModel.isShowingDetail.toggle()
                            }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("🥥 Cookerinho")
                .disabled(viewModel.isShowingDetail)
            }
            .blur(radius: (viewModel.isShowingDetail ? 10 : 0))
            .onAppear {
                viewModel.getDishes()
            }
            
            if viewModel.isShowingDetail {
                DishDetailView(isShowingDetail: $viewModel.isShowingDetail,
                               dish: viewModel.sellectedDish ?? MockData.sampleDish)
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
    DishListView()
}
