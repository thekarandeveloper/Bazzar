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
            
            VStack(spacing: 10){
                
                // Categories Selection
                HStack {
                    Text("Categories")
                        .font(.headline)
                    Spacer()
                }.padding(.top, 5)

                // Options Selection
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 12) {
                        CategoryChip(title: "All")
                        CategoryChip(title: "Men")
                        CategoryChip(title: "Women")
                        CategoryChip(title: "Girls")
                    }
                    .padding(.bottom, 5)
                }
                
                // Banner Selection
                ZStack(alignment: .bottomLeading) {
                          Image("bannerPhoto") 
                              .resizable()
                              .scaledToFill()
                              .frame(height: 250, )
                              .clipped()
                              .cornerRadius(12)
                      }
                      .frame(height: 250)
                  }
                
                
                
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
                        NavigationLink(destination: ProductView(product: product)) {
                            ProductCardView(product: product)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(width: 160, height: 200)
                }
                
                
        }.padding(0)
        
        }
        
    }
struct CategoryChip: View {
    var title: String
    
    var body: some View {
        NavigationLink(destination: ProductListView(
            title: title,
            products: DataManager.shared.products,
            filterCategory: title == "All" ? nil : title
        )) {
            Text(title)
                .font(.callout)
                .foregroundStyle(title == "All" ? Color.white : Color.black)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(title == "All" ? Color.orange : Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(PlainButtonStyle()) // removes blue default highlight
    }
}
    struct ProductCardView: View {
        @EnvironmentObject var wishlistManager: WishlistManager
        @State private var isWishlisted: Bool = false
            
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
                            Text("\(product.price, specifier: "%.2f")")
                                .font(.caption)
                                .foregroundColor(.orange)
                            Text("\(product.oldPrice, specifier: "%.2f")")
                                .font(.caption2)
                                .strikethrough()
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    Button {
                        // Toggle state
                        isWishlisted.toggle()
                       
                        if wishlistManager.isInWishlist(product: product) {
                                               wishlistManager.remove(productID: product.id!)
                                           } else {
                                               wishlistManager.add(product: product)
                                           }
                   
                    } label: {
                        Image(systemName: isWishlisted ? "heart.fill" : "heart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .foregroundStyle(isWishlisted ? Color.red : Color.black)
                            .cornerRadius(8)
                    }
                }
            }
            .frame(width: 160)
        }
    }

