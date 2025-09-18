import SwiftUI

struct ProductView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isWishlisted = false
    @State private var quantity = 1
    @StateObject private var razorpayManager = RazorpayManager()
    var body: some View {
        VStack(spacing: 0) {
            
            // Custom Top Bar
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .foregroundStyle(Color.black)
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
                
                Spacer()
                
                Text("Details")
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    razorpayManager.startPayment(amount: 69.0, productName: "Cotton T-Shirt")

                }) {
                    Image(systemName: "cart")
                        .resizable()
                        .foregroundStyle(Color.black)
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .frame(height: 44)
            
            // Scroll Content
            ScrollView(.vertical, showsIndicators: false) {
                VStack (alignment: .leading, spacing: 15){
                    Rectangle()
                        .fill(Color.orange.opacity(0.3))
                        .frame(height: 350)
                        .cornerRadius(12)
                      
                    
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            Text("Product Title")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top)
                            Spacer()
                            Text("$86.00")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top)
                        }
                        Spacer().frame(maxHeight: 20)
                        Text("Product Title")
                            .font(.caption)
                    }
                    
                    HStack {
                        VStack(alignment: .leading){
                            Text("Select Size")
                                .font(.caption)
                            HStack(spacing: 12) {
                                ForEach(["S", "M", "L", "XL", "XXL"], id: \.self) { size in
                                    Button(action: {
                                        print("\(size) selected")
                                    }) {
                                        Text(size)
                                            .font(.caption)
                                            .fontWeight(.medium)
                                            .frame(width: 40, height: 30)
                                            .background(Color.gray.opacity(0.2))
                                            .foregroundColor(.black)
                                            .cornerRadius(6)
                                    }
                                }
                            }
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 8) {
                                    Text("Quantity")
                                        .font(.caption)
                                    
                                    Picker("Select Quantity", selection: $quantity) {
                                        ForEach(1..<11) { number in // 1 se 10 tak
                                            Text("\(number)").tag(number)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                    .frame(width: 80, height: 30)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(6)
                                }
                     
                    }
                    Text("Description")
                        .font(.caption)
                    
                    Text("This is the product description. Add more details here.This is the product description. Add more details here.This is the product description. Add more details here.This is the product description. Add more details here. Add more details here.This is the product description. Add more details here.This is the product description. Add more details here.")
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 80)
            }
            .padding(16)
            // Bottom Buttons
            HStack(spacing: 12) {
                Button(action: {
                    print("Add to Cart pressed")
                }) {
                    HStack {
                        Image(systemName: "cart.fill")
                        Text("Add to Cart")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.black)
                    .cornerRadius(10) // rounded corners
                }
                
                Button(action: {
                    print("Buy Now pressed")
                }) {
                    HStack {
                        Image(systemName: "creditcard.fill")
                        Text("Buy Now")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10) // rounded corners
                }
            }
            .frame(height: 50) // proper button height
            .padding(.horizontal)
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        
    }
}
#Preview{
    ProductView()
}
