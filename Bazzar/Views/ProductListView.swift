//
//  ProductListView.swift
//  Bazzar
//
//  Created by Karan Kumar on 20/09/25.
//


import SwiftUI

struct ProductListView: View {
    var title: String // Navigation title
    var products: [Product] // All available products
    var filterCategory: String? = nil
    var searchQuery: String? = nil
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // Filtered products based on category or search
    var filteredProducts: [Product] {
        products.filter { product in
            if let category = filterCategory {
                return product.category.lowercased() == category.lowercased()
            }
            if let query = searchQuery, !query.isEmpty {
                return product.name.lowercased().contains(query.lowercased())
            }
            return true
        }
    }
    
    var body: some View {
        ScrollView {
            if filteredProducts.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray.opacity(0.6))
                    Text("No products found")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding()
            } else {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(filteredProducts) { product in
                        NavigationLink(destination: ProductView(product: product)) {
                            ProductCardView(product: product)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}