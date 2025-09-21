//
//  SelectAddressView.swift
//  Bazzar
//
//  Created by Karan Kumar on 21/09/25.
//


import SwiftUI
import SwiftData

struct SelectAddressView: View {
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Address.createdAt, order: .reverse) private var savedAddresses: [Address]
    @State private var selectedAddressID: String? = nil
    @EnvironmentObject var cartManager: CartManager
    @State private var showAlert = false
    @State private var inCart = false
    @StateObject private var razorpayManager = RazorpayManager()
    var product: Product
    var body: some View {
        VStack {
            if savedAddresses.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "house")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray.opacity(0.6))
                    Text("No saved addresses")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(savedAddresses) { address in
                            AddressCard(address: address,
                                        isSelected: selectedAddressID == address.id)
                                .onTapGesture {
                                    selectedAddressID = address.id
                                }
                        }
                    }
                    .padding()
                }
            }
            
            // Proceed Button
         
            Button(action: {
                if let selected = selectedAddressID {
                    print("Proceed with address ID: \(selected)")
                    if inCart{
                        razorpayManager.startPayment(amount: cartManager.totalAmount(), productName: "Cart")
                    } else{
                        razorpayManager.startPayment(amount: product.price, productName: "\(product.name)")
                    }
                  
                } else {
                    showAlert = true
                }
            }) {
                Text("Proceed to Payment")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(selectedAddressID == nil ? Color.gray : Color.orange)
                    .cornerRadius(12)
            }
            .alert("Please select an address", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .padding()
            .disabled(selectedAddressID == nil)
        }
        .navigationTitle("Select Address")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color("backgroundColor").ignoresSafeArea())
    }
}

// MARK: - Address Card
struct AddressCard: View {
    var address: Address
    var isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(address.name)
                    .font(.headline)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.orange)
                        .font(.title3)
                }
            }
            Text("\(address.street), \(address.city), \(address.state) - \(address.zip)")
                .font(.subheadline)
            Text("Phone: \(address.phone)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.orange : Color.gray.opacity(0.3), lineWidth: 2)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
        )
        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}
