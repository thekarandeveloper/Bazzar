import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.dismiss) private var dismiss
    @StateObject private var razorpayManager = RazorpayManager()
    var body: some View {
        VStack(spacing: 0) {
            
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
                                .environmentObject(cartManager)
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
        .navigationTitle("Cart")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Back") {
                    dismiss()
                }
            }
        }
    }
}

// MARK: - Cart Item Card
struct CartItemCard: View {
    @EnvironmentObject var cartManager: CartManager
    var item: CartItem
    
    var body: some View {
        HStack(spacing: 16) {
            
            // Product Image
            Image(item.product.imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
           
            // Product Details
            VStack(alignment: .leading, spacing: 6) {
                Text(item.product.name)
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                Text("$\(item.product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                HStack {
                    // Delete Button
                    Button(action: {
                        cartManager.removeFromCart(productID: item.product.id!)
                    }) {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.gray)
                            .frame(width: 52, height: 32)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(6)
                    }
                    
                    Spacer()
                    
                    // Quantity Picker
                    Picker("", selection: Binding(
                        get: { item.quantity },
                        set: { newQty in
                            cartManager.updateQuantity(productID: item.product.id!, quantity: newQty)
                        }
                    )) {
                        ForEach(1..<11) { qty in
                            Text("\(qty)").tag(qty)
                                .foregroundColor(.black)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                   
                    .frame(width: 70)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(Color.gray.opacity(0.2))
                    
                    .cornerRadius(6)
                }
            }.frame(maxWidth:.infinity)
            
           
        }
        
        .background(Color.white)
        .cornerRadius(16)
        
    }
}
