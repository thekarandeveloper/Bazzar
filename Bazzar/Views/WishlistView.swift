//
//  WishlistView.swift
//  Bazzar
//
//  Created by Karan Kumar on 20/09/25.
//

import SwiftUI

struct WishlistView: View {
    @EnvironmentObject var wishlistManager: WishlistManager
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        // Navbar
        CustomNavigationBarView(selectedTab: .home)
        
        ScrollView {
            if wishlistManager.items.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray.opacity(0.6))
                    Text("Your wishlist is empty")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding()
            } else {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(wishlistManager.items) { product in
                        ProductCardView(product: product)
                            .environmentObject(wishlistManager)
                    }
                }
                .padding()
            }
        }
        
    }
}
