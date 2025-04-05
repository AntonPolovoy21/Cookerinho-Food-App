//
//  WebSocketManager.swift
//  testing4
//
//  Created by Alex Polovoy on 5.04.25.
//

import Foundation
import SocketIO
import Combine

class WebSocketManager: ObservableObject {
    static let shared = WebSocketManager()
    
    private var manager: SocketManager!
    private var socket: SocketIOClient!
    @Published var orderStatus: PlacedOrderStatus = .waiting
    
    private init() {
        setupSocket()
    }
    
    private func setupSocket() {
        let url = URL(string: "http://localhost:3000")! // Используйте http вместо ws для Socket.IO
        manager = SocketManager(socketURL: url, config: [.log(true), .compress])
        socket = manager.defaultSocket
        
        setupEventHandlers()
    }
    
    private func setupEventHandlers() {
        socket.on(clientEvent: .connect) { _, _ in
            print("Соединение установлено")
        }
        
        socket.on("statusUpdate") { [weak self] data, _ in
            guard let jsonString = data.first as? String else { return }
            self?.updateOrderStatus(from: jsonString)
        }
        
        socket.on("updateOrderStatus") { [weak self] data, _ in
            guard let jsonString = data.first as? String else { return }
            self?.updateOrderStatus(from: jsonString)
        }
        
        socket.on(clientEvent: .error) { [weak self] data, _ in
            print("Ошибка соединения: \(data)")
            self?.orderStatus = .error
        }
        
        socket.on(clientEvent: .disconnect) { _, _ in
            print("Соединение разорвано")
        }
    }
    
    func connect() {
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    private func updateOrderStatus(from jsonString: String) {
        guard let data = jsonString.data(using: .utf8) else {
            orderStatus = .error
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let newStatusString = json["newStatus"] as? String {
                let statusMap: [String: PlacedOrderStatus] = [
                    "Выполнен": .completed,
                    "Отменен": .canceled,
                    "Готовится": .processing,
                    "Обрабатывается": .waiting
                ]
                
                if let status = statusMap[newStatusString] {
                    DispatchQueue.main.async {
                        self.orderStatus = status
                    }
                } else if let status = PlacedOrderStatus(rawValue: newStatusString) {
                    DispatchQueue.main.async {
                        self.orderStatus = status
                    }
                } else {
                    DispatchQueue.main.async {
                        self.orderStatus = .error
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.orderStatus = .error
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.orderStatus = .error
            }
        }
    }
}

