//
//  FavouriteDishesListView.swift
//  testing4
//
//  Created by Alex Polovoy on 31.03.25.
//

import SwiftUI

struct FavouriteDishesListView: View {
    
    @StateObject private var viewModel = FavouriteDishesListViewModel()
    @EnvironmentObject var listOfDishes: ListOfDishes
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                NavigationView{
                    List {
                        ForEach(viewModel.favouriteDishesList) { dish in
                            DishCellView(dish: dish)
                                .listRowSeparator(.visible)
                                .onTapGesture {
                                    viewModel.selectedFavouriteDish = dish
                                    viewModel.isShowingDetail.toggle()
                                }
                        }
                        .onDelete {
                            viewModel.remove($0)
                        }
                    }
                    .listStyle(.plain)
                    .disabled(viewModel.isShowingDetail)
                }
                .blur(radius: (viewModel.isShowingDetail ? 10 : 0))
                .task {
                    loadFavouriteDishes()
                }
                if viewModel.isShowingDetail {
                    FavouriteDishDetailView(isShowingDetail: $viewModel.isShowingDetail,
                                   dish: viewModel.selectedFavouriteDish ?? MockData.sampleDish)
                    .position(CGPoint(x: geometry.size.width / 2, y: -geometry.size.height / 2))
                }
            }
        }
    }
    
    private func loadFavouriteDishes() {
        if let savedIdsString = UserDefaults.standard.string(forKey: "favouriteDishes") {
            
            let idsArray = savedIdsString.split(separator: "-").compactMap { Int($0) }
            
            print(savedIdsString, idsArray)
            
            DispatchQueue.main.async {
                self.viewModel.favouriteDishesList.removeAll()
                
                for myId in idsArray {
                    if let dish = listOfDishes.dishesItems.first(where: { $0.id == myId }) {
                        self.viewModel.add(dish)
                    }
                }
            }
        } else {
            self.viewModel.favouriteDishesList = []
        }
    }
}

#Preview {
    FavouriteDishesListView()
}
