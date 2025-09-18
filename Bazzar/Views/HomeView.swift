//
//  HomeView.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//

import SwiftUI

struct HomeView: View{
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View{
       
        ScrollView(.vertical, showsIndicators: false){
            
            // Navbar
            CustomNavigationBarView(selectedTab: .home)
            
            VStack(spacing: 20){
                
                // Categories Selection
                
                HStack{
                    Text("Categories")
                        .font(.headline)
                    Spacer()
                }
                
                // Options Selection
                
                HStack(alignment: .center, spacing: 20){
                    
                    Text("All")
                        .font(.callout)
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    Text("Men")
                        .foregroundStyle(Color.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    Text("Women")
                        .foregroundStyle(Color.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    Text("Girls")
                        .foregroundStyle(Color.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
                
                
                // Banner Selection
                
                ZStack {
                    // Background orange gradient
                    LinearGradient(
                        gradient: Gradient(colors: [Color.orange.opacity(0.8), Color.orange.opacity(0.5)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .cornerRadius(12)
                    
                    HStack {
                        // Left Text
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Mega Sale!")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("Up to 50% off on selected items")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .padding()
                        
                        Spacer()
                        
                        // Right Image
                        Image("bannerProduct") // Replace with your product image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .padding(.trailing)
                    }
                }
                .frame(height: 250)
               
                
                
                
                // Products Selection
                
                HStack{
                    Text("Popular Product")
                        .font(.headline)
                    Spacer()
                    Text("See All")
                        .font(.caption)
                }
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(DataManager.shared.products) { product in
                        NavigationLink(destination: ProductView()) {
                            ProductCardView(product: product)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(width: 160, height: 200)
                }
                
                
        }.padding(0)
        
        }
        
    }
    struct ProductCardView: View {
        
        var product: Product
        
        var body: some View {
            VStack(spacing: 12) {
                Image("\(product.imageUrl)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 150)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(product.name)")
                            .font(.headline)
                        HStack(spacing: 6) {
                            Text("\(product.price)")
                                .font(.caption)
                                .foregroundColor(.orange)
                            Text("\(product.oldPrice)")
                                .font(.caption2)
                                .strikethrough()
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    Button {
                        print("Bell pressed")
                    } label: {
                        Image(systemName: "cart.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .padding(8)
                            .background(Color.orange)
                            .foregroundStyle(Color.white)
                            .cornerRadius(8)
                    }
                }
            }
            .frame(width: 160)
        }
    }

