//
//  ContentView.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//


import SwiftUI

struct ContentView: View {
    
//    @State var searchtext: String
    
    var body: some View {
        TabView {
            
            // Home Tab
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            // WishList
            NavigationStack {
                WishListView()
            }
            .tabItem {
                Label("WishList", systemImage: "magnifyingglass")
            }

            // Profile Tab
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "star")
            }
        }
    }
}
