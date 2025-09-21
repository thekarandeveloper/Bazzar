//
//  Order.swift
//  Bazzar
//
//  Created by Karan Kumar on 21/09/25.
//


import SwiftUI
import Combine

// MARK: - Order Model
struct Order: Identifiable {
    let id = UUID()
    let product: Product
    let amount: Double
    let date: Date
    var status: OrderStatus
}

enum OrderStatus {
    case success(paymentID: String)
    case failure(error: String)
}

// MARK: - Order Manager
class OrderManager: ObservableObject {
    @Published var orders: [Order] = []
    
    func addOrder(product: Product, amount: Double, status: OrderStatus) {
        let order = Order(product: product, amount: amount, date: Date(), status: status)
        orders.append(order)
    }
    
    func clearOrders() {
        orders.removeAll()
    }
    func isProductOrdered(product: Product) -> Bool {
            return orders.contains { $0.product.id == product.id }
        }
}
