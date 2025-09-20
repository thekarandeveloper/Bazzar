//
//  WishlistManager.swift
//  Bazzar
//
//  Created by Karan Kumar on 20/09/25.
//


import SwiftUI

class WishlistManager: ObservableObject {
    @Published var items: [Product] = []
    
    // Add to wishlist
    func add(product: Product) {
        if !items.contains(where: { $0.id == product.id }) {
            items.append(product)
        }
    }
    
    // Remove from wishlist
    func remove(productID: String) {
        items.removeAll { $0.id == productID }
    }
    
    // Check if in wishlist
    func isInWishlist(product: Product) -> Bool {
        return items.contains { $0.id == product.id }
    }
    
    // Count (for badge)
    var totalItems: Int {
        items.count
    }
}