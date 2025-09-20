//
//  CartView.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Navbar (optional custom)
            CustomNavigationBarView(selectedTab: .cart)
            
            if cartManager.items.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "cart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray.opacity(0.6))
                    Text("Your cart is empty")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(cartManager.items) { item in
                            CartItemCard(item: item)
                        }
                    }
                    .padding()
                }
                
                // Footer
                VStack(spacing: 12) {
                    HStack {
                        Text("Total:")
                            .font(.headline)
                        Spacer()
                        Text("$\(cartManager.totalAmount(), specifier: "%.2f")")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                    
                    Button(action: {
                        print("Proceed to checkout")
                    }) {
                        Text("Checkout")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(12)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Cart Item Card
struct CartItemCard: View {
    @EnvironmentObject var cartManager: CartManager
    var item: CartItem
    
    var body: some View {
        HStack(spacing: 12) {
            
            // Product Image
            AsyncImage(url: URL(string: item.product.imageUrl)) { phase in
                if let image = phase.image {
                    image.resizable().scaledToFill()
                } else if phase.error != nil {
                    Color.red.opacity(0.3)
                } else {
                    ProgressView()
                }
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            // Product Details
            VStack(alignment: .leading, spacing: 6) {
                Text(item.product.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text("$\(item.product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.orange)
                
                // Quantity dropdown
                Picker("Qty", selection: Binding(
                    get: { item.quantity },
                    set: { newQty in
                        cartManager.updateQuantity(productID: item.product.id!, quantity: newQty)
                    }
                )) {
                    ForEach(1..<11) { qty in
                        Text("\(qty)").tag(qty)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 100)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            }
            
            Spacer()
            
            // Remove button
            Button {
                cartManager.removeFromCart(productID: item.product.id!)
            } label: {
                Image(systemName: "trash.fill")
                    .foregroundColor(.red)
                    .padding(8)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
