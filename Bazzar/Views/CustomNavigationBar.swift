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
                
                // Left Icon
                Button(action: {
                    goToProfile = true
                }) {
                    Image("girlPhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .buttonStyle(PlainButtonStyle())
                
                
                
                // Center Text
                VStack(alignment: .leading, spacing: 2) {
                    Text("Hello Allex")
                        .font(.callout)
                        .fontWeight(.medium)
                    Text("Good Morning")
                        .font(.headline)
                        .fontWeight(.bold)
                }
               

                Spacer()

         
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
            
           
            // Right Buttons
            HStack(spacing: 12) {
                Button {
                    print("Bell pressed")
                } label: {
                    Image(systemName: "bell.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }

                Button {
                    print("Ellipsis pressed")
                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
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
                .navigationTitle("Notification")
                .navigationBarTitleDisplayMode(.inline)
        }
        
        .sheet(isPresented: $goToNotification){
            ProfileView()
                .navigationTitle("Profile")
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
