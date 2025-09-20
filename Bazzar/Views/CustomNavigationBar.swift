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
    @StateObject private var searchViewModel = SearchViewModel()

    var body: some View {
        HStack(spacing: 12) {
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                
                TextField("Search", text: $searchViewModel.searchText)
                    .font(.subheadline)
                    .padding(8)
            }
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(Color.gray.opacity(0.2))
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
       
    }
}
