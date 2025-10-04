//
//  CustomNavigationBar.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//

import SwiftUI
import SwiftData
struct CustomNavigationBarView: View {
    @EnvironmentObject var cartManager: CartManager
    @State var selectedTab: Tab
    @State private var goToCart = false
    @State private var goToProfile = false
    @StateObject private var searchViewModel = SearchViewModel()
    @StateObject var searchManager = SearchManager(products: DataManager.shared.products)
    @EnvironmentObject var wishlistManager: WishlistManager
    @EnvironmentObject var authManager: AuthenticationManager

    var body: some View {
        HStack(spacing: 12) {
            
            Button {
                   goToProfile = true
               } label: {
                   Image(systemName: "person.fill")
                       .resizable()
                       .scaledToFit()
                       .frame(width: 24, height: 24)
                       .foregroundColor(.gray)
                       .padding(.vertical, 8)
                       .padding(.horizontal, 8)
                       .background(Color.gray.opacity(0.2))
                       .cornerRadius(12)
               }
            
            // Search Bar
            SearchBarView(searchManager: searchManager)
                .environmentObject(wishlistManager)
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
            // Cart Button with Badge
            Button {
                goToCart = true
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "cart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                       
                    if cartManager.totalItems > 0 {
                        Text("\(cartManager.totalItems)")
                            .font(.caption2)
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.red)
                            .clipShape(Circle())
                            .transition(.scale) 
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, cartManager.totalItems > 0 ? 12 : 8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .animation(.spring(), value: cartManager.totalItems)
            }
        
        }
        .frame(height: 45)
        .sheet(isPresented: $goToCart){
            NavigationStack {
                CartView()
                    .navigationTitle("Cart")
                    .navigationBarTitleDisplayMode(.inline)
                }
               
        }
        .sheet(isPresented: $goToProfile) {
            NavigationStack {
                if authManager.isAuthenticated {
                    ProfileView()
                        .navigationTitle("Profile")
                        .navigationBarTitleDisplayMode(.inline)
                } else {
                    OnboardingView()
                }
            }
        }
       
    }
}
struct SearchBarView: View {
    @StateObject var searchManager: SearchManager
    @EnvironmentObject var wishlistManager: WishlistManager
    @State private var goToResults = false
    
    var body: some View {
        VStack {
            
            HStack {
                
              
                
                TextField("Search products...", text: $searchManager.query, onCommit: {
                    searchManager.performSearch()
                    goToResults = true
                })
                .textFieldStyle(PlainTextFieldStyle()) // simple style
                .submitLabel(.search)

                Button(action: {
                    searchManager.performSearch()
                    goToResults = true
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                }
            }
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
            NavigationLink(destination:
                            ProductListView(title: "Search Results",
                                            products: searchManager.filteredProducts)
                            .environmentObject(wishlistManager),
                           isActive: $goToResults) {
                EmptyView()
            }
        }
    }
}
