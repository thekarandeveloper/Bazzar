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
    @State var inCart = false
    @StateObject private var razorpayManager = RazorpayManager()
    @EnvironmentObject var orderManager: OrderManager
    
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
                   
                    if inCart{
                       print("is in cart", inCart)
                        DispatchQueue.main.async {
                            
                            razorpayManager.startPayment(amount: cartManager.totalAmount(), productName: "Cart")
                        }
                    } else {
                        print("is in cart", inCart)
                        DispatchQueue.main.async {
                            razorpayManager.startPayment(amount: product.price, productName: "\(product.name)")
                        }
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
        }.navigationDestination(isPresented: Binding(
            get: {
                if case .success = razorpayManager.paymentStatus { return true }
                if case .failure = razorpayManager.paymentStatus { return true }
                return false
            },
            set: { _ in }
        )) {
            // Only return a view here
            Group {
                switch razorpayManager.paymentStatus {
                case .success(let id):
                    PaymentSuccessView(paymentID: id)
                        .onAppear {
                            orderManager.addOrder(product: product, amount: product.price, status: .success(paymentID: id))
                           
                        }

                case .failure(let error):
                    PaymentFailureView(errorMessage: error)
                        .onAppear {
                            orderManager.addOrder(product: product, amount: product.price, status: .failure(error: error))
                         
                        }

                default:
                    EmptyView()
                }
            }
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

struct PaymentSuccessView: View {
    let paymentID: String
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var orderManager: OrderManager
   
    @State private var show = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.green)
                    .scaleEffect(show ? 1 : 0.5)
                    .animation(.spring(response: 0.5), value: show)
                
                Text("Payment Successful!")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.green)
                
                Text("Transaction ID:\n\(paymentID)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(30)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .onAppear {
                show = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    dismiss()
                }
            }
        }
    }
}

struct PaymentFailureView: View {
    let errorMessage: String
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var orderManager: OrderManager
   
    @State private var show = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "xmark.octagon.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.red)
                    .scaleEffect(show ? 1 : 0.5)
                    .animation(.spring(response: 0.5), value: show)
                
                Text("Payment Failed")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.red)
                
                Text(errorMessage)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(30)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .onAppear {
                show = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    dismiss()
                }
            }
        }
    }
}
