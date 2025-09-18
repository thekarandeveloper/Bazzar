//
//  ContentView.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//


import SwiftUI
import SwiftData
struct ContentView: View {
    
    @State private var selectedTab: Tab = .home
    @State private var showAddScreen = false
    @Environment(\.modelContext) private var context
   
    var body: some View {
        
        ZStack(alignment: .bottom){
            
            
          
            // Content of selected tab
            
            Group {
                switch selectedTab {
                case .home:
                    NavigationStack{HomeView()}
                case .categories:
                    NavigationStack{CategoryView()}
                case .cart:
                    NavigationStack{CartView()}
                case .account:
                    NavigationStack{ProfileView()}
                }
            }
            CustomTabbar(selectedTab: $selectedTab)
           
           
        }
    }
}


