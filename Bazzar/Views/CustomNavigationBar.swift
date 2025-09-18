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
    @Query var user: [User]
    var body: some View {
        HStack {
            switch selectedTab {
            case .home:
                Button {
                    goToProfile = true
                } label: {
                    HStack {
                        Image("Mark")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        VStack(alignment: .leading) {
                            Text("Hi, \(user.first?.name ?? "User")").font(.headline).foregroundStyle(.black)
                            Text("Welcome Back").font(.caption).foregroundStyle(.black)
                        }
                    }
                }
                
         
            case .categories:
                Text("Categories")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            case .cart:
                Text("Cart")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            case .account:
                Text("Account")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            Button {
                goToNotification = true
            } label: {
                Image(systemName: "bell")
                    .foregroundStyle(.black)
                    .font(.system(size: 24, weight: .light))
                    .frame(width: 50, height: 50)
                    .padding(1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
            }
        }
        .frame(height: 60)
        
        // Attach Screens
        .sheet(isPresented: $goToProfile){
            
            NavigationStack{
                
                ProfileView()
                    .presentationDragIndicator(.visible)
            }
         
        }
        .navigationDestination(isPresented: $goToNotification) {
            NotificationView()
                .navigationTitle("Notification View")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        CustomNavigationBarView(selectedTab: .home)
    }
}
#Preview{
    CustomNavigationBarView(selectedTab: .home)
}
