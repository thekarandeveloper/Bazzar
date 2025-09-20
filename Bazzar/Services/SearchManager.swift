//
//  SearchManager.swift
//  Bazzar
//
//  Created by Karan Kumar on 20/09/25.
//


import SwiftUI
import Combine

class SearchManager: ObservableObject {
    @Published var query: String = ""
    
    // Optional: To hold filtered results
    @Published var filteredProducts: [Product] = []
    
    // All products reference (you can inject or fetch from DataManager)
    var allProducts: [Product] = []
    
    init(products: [Product]) {
        self.allProducts = products
    }
    
    // Perform search
    func performSearch() {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            filteredProducts = []
            return
        }
        
        filteredProducts = allProducts.filter { product in
            product.name.lowercased().contains(trimmed.lowercased()) ||
            product.category.lowercased().contains(trimmed.lowercased())
        }
    }
}