//
//  ConfirmationView.swift
//  testing4
//
//  Created by Alex Polovoy on 3.04.25.
//

import SwiftUI

struct ConfirmationView: View {
    @Binding var isPresented: Bool
    @Binding var wasOrderPlaced: Bool
    
    @EnvironmentObject var order: Order
    
    @State private var name: String = UserDefaults.standard.string(forKey: "usersFirstName") ?? ""
    @State private var phoneNumber: String = UserDefaults.standard.string(forKey: "usersPhoneNumber") ?? ""
    @State private var deliveryTime: String = ""
    @State private var paymentMethod: String = ""
    @State private var comments: String = ""
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertType: CustomAlertType = .error
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            VStack{
                
                HStack{
                    
                    Spacer()
                    
                    Image("shape")
                    
                }
                
                VStack{
                    
                    Image("logo")
                    Text("Cookerinho")
                        .font(.system(size: 20, weight: .regular, design: .monospaced))
                    
                }.offset(y: -122)
                    .padding(.bottom,-132)
                
                VStack(spacing: 30){
                    
                    Text("Оформите ваш заказ")
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    
                    CustomTF(value: self.$name, isName: true)
                    
                    CustomTF(value: self.$phoneNumber, isPhoneNumber: true)
                    
                    HStack {
                        VStack {
                            Text("Через сколько минут  заберете?")
                                .foregroundColor(Color.black.opacity(0.5))
                            Picker("", selection: $deliveryTime) {
                                Text("20 мин.").tag("20 минут")
                                Text("25 мин.").tag("25 минут")
                                Text("30 мин.").tag("30 минут")
                                Text("35 мин.").tag("35 минут")
                                Text("40 мин.").tag("40 минут")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        VStack {
                            Text("Способ оплаты")
                                .foregroundColor(Color.black.opacity(0.5))
                            Picker("", selection: $paymentMethod) {
                                Text("Картой").tag("Картой при получении")
                                Text("Наличными").tag("Наличными при получении")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Spacer()
                    }
                    
                    VStack {
                        Text("Товары в заказе \(order.orderItems.count) шт.")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(Color.black.opacity(0.5))
                        Text("Итого: \(order.orderPrice, specifier: "%.2f") Br")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    Button(action: {
                        if validateInputs() {
                            createOrder()
                        }
                        else {
                            showAlert = true
                        }
                    }) {
                        
                        Text("Заказать")
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .padding(.vertical)
                            .foregroundColor(.white)
                        
                    }
                    .background(Color("Color1"))
                    .clipShape(Capsule())
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                .padding()
                
                
                Spacer(minLength: 0)
                
            }
            .onAppear {
                self.name = UserDefaults.standard.string(forKey: "usersFirstName") ?? ""
            }
            .edgesIgnoringSafeArea(.top)
            .background(Color("Color").edgesIgnoringSafeArea(.all))
            
            CustomAlertView(wrappedState: $showAlert, withDetails: $alertMessage, type: alertType)
            
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    private func validateInputs() -> Bool {
        guard !name.isEmpty else {
            alertMessage = "Пожалуйста, введите имя"
            alertType = .warning
            
            return false
        }
        
        let phoneRegex = "^\\+375 \\(\\d{2}\\) \\d{3} \\d{2} \\d{2}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        if !phonePredicate.evaluate(with: phoneNumber) {
            alertMessage = "Пожалуйста, введите номер телефона в формате +375 (xx) xxx xx xx"
            alertType = .warning
            
            return false
        }
        
        UserDefaults.standard.set(phoneNumber, forKey: "usersPhoneNumber")
        
        guard !deliveryTime.isEmpty, !paymentMethod.isEmpty else {
            alertMessage = "Пожалуйста, выберите время и способ оплаты"
            alertType = .warning
            
            return false
        }
        
        alertMessage = "Ваш заказ оформлен и передан в ресторан!"
        alertType = .ok
        
        return true
    }
    
    private func createOrder() {
            let url = URL(string: "http://localhost:3000/orders/makeNewOrder")!
            let orderData: [String: Any] = [
                "dishes": order.orderItems.map { ["name": $0.name] },
                "customer": name,
                "pickUp": deliveryTime,
                "paymentMethod": paymentMethod,
                "totalPrice": order.orderPrice,
                "phoneNumber": phoneNumber,
                "orderStatus": "Обрабатывается"
            ]
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: orderData, options: [])
            } catch {
                print("Error serializing JSON: \(error)")
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error making request: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        alertMessage = "Ошибка при создании заказа"
                        alertType = .error
                        showAlert = true
                    }
                    return
                }
                
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isPresented = false
                        }
                        
                        showAlert = true
                        wasOrderPlaced = true
                        UserDefaults.standard.set(true, forKey: "wasOrderPlaced")
                    }
                }
            }
            
            task.resume()
        }
}

#Preview {
    ConfirmationView(isPresented: .constant(true), wasOrderPlaced: .constant(false))
        .environmentObject(Order())
}
