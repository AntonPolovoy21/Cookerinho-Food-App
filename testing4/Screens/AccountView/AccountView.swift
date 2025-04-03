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
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertType: CustomAlertType = .error
    
    enum TextFieldType {
        case firstName, lastName, email
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 10) {
                    ProfilePhotoPickerView()
                    
                    Form {
                        Section(header: Text("Персональные данные")) {
                            TextField("Имя", text: $viewModel.user.firstName)
                                .focused($focusedField, equals: .firstName)
                                .onSubmit() { focusedField = .lastName }
                                .submitLabel(.next)
                            
                            TextField("Фамилия", text: $viewModel.user.lastName)
                                .focused($focusedField, equals: .lastName)
                                .onSubmit() { focusedField = nil }
                                .submitLabel(.done)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                            
                            DatePicker(
                                "Дата рождения",
                                selection: $viewModel.user.birthDate,
                                in: Date().oneHundredTenYearsAgo...Date().sixYearsAgo,
                                displayedComponents: .date
                            )
                            .tint(.accent)
                            
                            Button {
                                focusedField = nil
                                
                                guard viewModel.isValidForm else {
                                    showAlert = true
                                    alertMessage = "Не все поля заполнены"
                                    alertType = .warning
                                    
                                    return
                                }
                                
                                do {
                                    let data = try JSONEncoder().encode(viewModel.user)
                                    viewModel.userData = data
                                    
                                    showAlert = true
                                    alertMessage = "Данные вашего профиля были успешно сохранены!"
                                    alertType = .ok
                                    
                                    UserDefaults.standard.set(viewModel.user.firstName, forKey: "usersFirstName")
                                    UsersServerManager.updateUserName(withFirstName: viewModel.user.firstName, withLastName: viewModel.user.lastName)
                                }
                                catch {
                                    showAlert = true
                                    alertMessage = "Произошла ошибка при загрузке вашей личной информации"
                                    alertType = .error
                                }
                            } label: {
                                Text("Сохранить изменения")
                            }
                        }
                    }
                    .onAppear {
                        guard let userData = viewModel.userData else { return }
                        
                        do {
                            viewModel.user = try JSONDecoder().decode(User.self, from: userData)
                        }
                        catch {
                            showAlert = true
                            alertMessage = "Произошла ошибка при загрузке вашей личной информации"
                            alertType = .error
                        }
                    }
                    .toolbar{
                        ToolbarItemGroup(placement: .keyboard) {
                            Button("Готово") { focusedField = nil }
                        }
                    }
                    .navigationTitle("🤣 Профиль")
                    
                    Text("⭐ Избранное ⭐")
                        .bold()
                        .font(.headline)
                    FavouriteDishesListView()
                }
                
                CustomAlertView(wrappedState: $showAlert, withDetails: $alertMessage, type: alertType)
                    .padding(.bottom, 2)
                    .opacity(showAlert ? 1 : 0)
            }
        }
    }
}

#Preview {
    AccountView()
}
