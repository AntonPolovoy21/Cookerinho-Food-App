//
//  AccountView.swift
//  testing4
//
//  Created by Anton Polovoy on 2.11.24.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject private var viewModel = AccountViewModel()
    @FocusState private var focusedField: TextFieldType?
    
    enum TextFieldType {
        case firstName, lastName, email
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ProfilePhotoPickerView()
                
                Form {
                    Section(header: Text("Personal info")) {
                        TextField("First Name", text: $viewModel.user.firstName)
                            .focused($focusedField, equals: .firstName)
                            .onSubmit() { focusedField = .lastName }
                            .submitLabel(.next)
                        
                        TextField("Last Name", text: $viewModel.user.lastName)
                            .focused($focusedField, equals: .lastName)
                            .onSubmit() { focusedField = nil }
                            .submitLabel(.done)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        DatePicker(
                            "Birth date",
                            selection: $viewModel.user.birthDate,
                            in: Date().oneHundredTenYearsAgo...Date().sixYearsAgo,
                            displayedComponents: .date
                        )
                        .tint(.accent)
                        
                        Button {
                            viewModel.saveChanges()
                        } label: {
                            Text("Save changes")
                        }
                    }
                }
                .onAppear {
                    viewModel.retrieveUser()
                }
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Dismiss") { focusedField = nil }
                    }
                }
                .navigationTitle("🤣 Account")
                
                Text("⭐ Избранное ⭐")
                    .bold()
                    .font(.headline)
                FavouriteDishesListView()
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
    AccountView()
}
