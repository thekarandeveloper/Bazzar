//
//  ContentView.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        TabView {
            
            // Home Tab
            NavigationStack {
                HomeView()
                    .padding(20)
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            // Categories Tab
            NavigationStack {
                CategoryView()
                    .padding(20)
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Categories", systemImage: "square.grid.2x2.fill")
            }
            
            // Cart Tab
            NavigationStack {
                CartView()
                    .padding(20)
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Wishlist", systemImage: "heart.fill")
            }
            
            // Profile Tab
            NavigationStack {
                ProfileView()
                    .padding(20)
                    .navigationBarBackButtonHidden(true)
            }
            .tabItem {
                Label("Account", systemImage: "person.fill")
            }
        }
        .accentColor(.orange) // Selected tab icon color
    }
}
