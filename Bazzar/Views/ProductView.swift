//
//  ProductView.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//

import SwiftUI

struct ProductView: View {
    @State private var isWishlisted = false
    @State private var quantity = 1
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Banner
            Image("girlPhoto") // replace with product image
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .clipped()
                .overlay(
                    // Top Bar (Back + Wishlist)
                    HStack {
                        Button {
                            print("Back pressed")
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.4))
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        Button {
                            isWishlisted.toggle()
                        } label: {
                            Image(systemName: isWishlisted ? "heart.fill" : "heart")
                                .foregroundColor(isWishlisted ? .orange : .white)
                                .padding()
                                .background(Color.black.opacity(0.4))
                                .clipShape(Circle())
                        }
                    }
                    .padding(),
                    alignment: .top
                )
            
            // Content
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Title
                    Text("Cotton T-shirt")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Ratings
                    HStack(spacing: 4) {
                        ForEach(0..<5) { i in
                            Image(systemName: i < 4 ? "star.fill" : "star")
                                .foregroundColor(.orange)
                        }
                        Text("(120 Reviews)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // Description
                    Text("This premium cotton T-shirt is lightweight, soft and breathable. Perfect for daily wear and casual outings.")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    // Price
                    HStack(spacing: 10) {
                        Text("$69.00")
                            .font(.title2)
                            .foregroundColor(.orange)
                        Text("$169.00")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .strikethrough()
                    }
                    
                    // Quantity Selector (optional)
                    Stepper("Quantity: \(quantity)", value: $quantity, in: 1...10)
                        .padding(.top)
                }
                .padding()
            }
            
            // Bottom Action Buttons
            HStack(spacing: 16) {
                Button(action: {
                    print("Added to Cart")
                }) {
                    Text("Add to Cart")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
            .background(Color.white.shadow(radius: 2))
        }
        .ignoresSafeArea(edges: .top) // banner full screen top
    }
}

#Preview {
    ProductView()
}
