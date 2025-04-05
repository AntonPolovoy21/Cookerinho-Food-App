//
//  PlacedOrderStatus.swift
//  testing4
//
//  Created by Alex Polovoy on 5.04.25.
//

import Foundation

enum PlacedOrderStatus: String {
    case completed = "Выполнен"
    case canceled = "Отменен"
    case processing = "Готовится"
    case waiting = "Обрабатывается"
    case error = "Ошибка"
}
