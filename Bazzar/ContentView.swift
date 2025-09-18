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
                    NavigationStack{HomeView().padding(20)}.navigationBarBackButtonHidden(true)
                case .categories:
                    NavigationStack{CategoryView().padding(20)}.navigationBarBackButtonHidden(true)
                case .cart:
                    NavigationStack{CartView().padding(20)}.navigationBarBackButtonHidden(true)
                case .account:
                    NavigationStack{ProfileView().padding(20)}.navigationBarBackButtonHidden(true)
                }
            }
            CustomTabbar(selectedTab: $selectedTab)
           
           
        }
    }
}


