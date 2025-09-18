//
//  CustomNavigationBar.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//

import SwiftUI
import SwiftData
struct CustomNavigationBarView: View {
    
    @State var selectedTab: Tab
    @State private var goToProfile = false
    @State private var goToNotification = false
    @StateObject private var searchViewModel = SearchViewModel()
    
    @Query var user: [User]
    var body: some View {
        HStack(spacing: 12) {
            // Search Bar 80%
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
            
            // Button 20%
            Button {
                print("Button pressed")
            } label: {
                Image(systemName: "bell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .padding(8)
                    .foregroundColor(.orange)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            
        }
        .frame(height: 45)
        
        
        // Attach Screens
        .sheet(isPresented: $goToProfile){
            
            NavigationStack{
                
                ProfileView()
                    .presentationDragIndicator(.visible)
            }
         
        }
        .navigationDestination(isPresented: $goToNotification) {
            NotificationView()
                .navigationTitle("Notification")
                .navigationBarTitleDisplayMode(.inline)
        }
        
        .sheet(isPresented: $goToNotification){
            ProfileView()
                .navigationTitle("Profile")
        }
        
    }
}
