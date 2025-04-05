//
//  OrderPlacedView.swift
//  testing4
//
//  Created by Alex Polovoy on 4.04.25.
//

import SwiftUI

struct OrderPlacedView: View {
    @Binding var wasOrderPlaced: Bool
    @StateObject private var webSocketManager = WebSocketManager.shared
    
    var body: some View {
        VStack {
            
            VStack(spacing: 30){
                CustomIndicatorView(type: getIndicatorType(from: webSocketManager.orderStatus))
                
                Text(getMainText(from: webSocketManager.orderStatus))
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                
                Text(getDescriptionText(from: webSocketManager.orderStatus))
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    webSocketManager.disconnect()
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
                .opacity(webSocketManager.orderStatus == .waiting ? 1 : 0) 
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color.white)
            .ignoresSafeArea()
        }
        .onAppear {
            webSocketManager.connect()
        }
        .onDisappear {
            webSocketManager.disconnect()
        }
    }
    
    private func getIndicatorType(from status: PlacedOrderStatus) -> CustomAlertType {
        switch status {
        case .waiting:
            return .warning
        case .processing:
            return .warning
        case .canceled:
            return .error
        case .completed:
            return .ok
        case .error:
            return .error
        }
    }
    
    private func getMainText(from status: PlacedOrderStatus) -> String {
        switch status {
        case .waiting:
            return "Ваш заказ отправлен на обработку!"
        case .processing:
            return "Ваш заказ готовится!"
        case .canceled:
            return "Ваш заказ отменен"
        case .completed:
            return "Ваш заказ готов к выдаче!"
        case .error:
            return "Произошла ошибка с заказом"
        }
    }
    
    private func getDescriptionText(from status: PlacedOrderStatus) -> String {
        switch status {
        case .waiting:
            return "На этой странице вы можете отслеживать статус вашего заказа. Статус изменится как только ресторан примет ваш заказ"
        case .processing:
            return "Ваш заказ уже начали готовить в ресторане!"
        case .canceled:
            return "К сожалению, ваш заказ был отменен"
        case .completed:
            return "Ваш заказ готов! Вы можете забрать его в ресторане"
        case .error:
            return "Произошла ошибка с вашим заказом. Пожалуйста, обратитесь в ресторан для решения проблемы."
        }
    }
}



#Preview {
    OrderPlacedView(wasOrderPlaced: .constant(true))
}
