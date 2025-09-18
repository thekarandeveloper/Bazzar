//
//  CategoryDetail.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//

import SwiftUI

struct CategoryDetailView: View {
    var categoryName: String
    
    // Dummy products for demo
    let products = Array(repeating: Product(name: "Cotton T-shirt", price: "$69.00", oldPrice: "$169.00", imageName: "girlPhoto"), count: 10)
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 20) {
                
                Text(categoryName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Horizontal scrollable product cards
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.fixed(200))], spacing: 16) {
                        ForEach(products.indices, id: \.self) { index in
                            NavigationLink(destination: ProductView()) {
                                ProductCardHorizontalView(product: products[index])
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 220) // height for horizontal row
            }
        }
        .navigationTitle(categoryName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Product Model
struct Product {
    let name: String
    let price: String
    let oldPrice: String
    let imageName: String
}

// MARK: - Horizontal Product Card
struct ProductCardHorizontalView: View {
    var product: Product
    
    var body: some View {
        VStack(spacing: 12) {
            Image(product.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 120)
                .clipped()
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                    .lineLimit(1)
                
                HStack(spacing: 6) {
                    Text(product.price)
                        .font(.caption)
                        .foregroundColor(.orange)
                    Text(product.oldPrice)
                        .font(.caption2)
                        .strikethrough()
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(width: 160)
    }
}

#Preview {
    NavigationStack {
        CategoryDetailView(categoryName: "Men")
    }
}
