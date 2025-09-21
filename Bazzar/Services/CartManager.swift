//
//  CartManager.swift
//  Bazzar
//
//  Created by Karan Kumar on 20/09/25.
//


import Foundation
import SwiftUI
import SwiftData
import FirebaseFirestore

class CartManager: ObservableObject {
    @Published var items: [CartItem] = []
    var totalItems: Int {
           items.reduce(0) { $0 + $1.quantity }
       }
       
    func addToCart(product: Product, quantity: Int = 1) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += quantity
        } else {
            items.append(CartItem(id: product.id ?? UUID().uuidString, product: product, quantity: quantity))
        }
    }

    func removeFromCart(productID: String) {
        items.removeAll { $0.id == productID }
    }

    func updateQuantity(productID: String, quantity: Int) {
        if let index = items.firstIndex(where: { $0.id == productID }) {
            items[index].quantity = quantity
        }
    }

    func totalAmount() -> Double {
        items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    func isInCart(product: Product) -> Bool {
        return items.contains { $0.product.id == product.id }
    }
    
  
      
    
}
