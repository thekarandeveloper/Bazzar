//
//  ProfileView.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//
import SwiftUI

struct ProfileView: View {
    @State private var showSettings = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Navbar
                CustomNavigationBarView(selectedTab: .home)
               
                // Header Banner
                ZStack(alignment: .bottom) {
                    LinearGradient(colors: [Color.orange.opacity(0.8), Color.orange.opacity(0.5)],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .frame(height: 180)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                    VStack(spacing: 8) {
                        Image("girlPhoto")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 5)
                        
                        Text("Alex Johnson")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("alex.johnson@example.com")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .offset(y: 50)
                }
                .padding(.bottom, 50)
                
                // Statistics Section
                HStack(spacing: 20) {
                    StatCard(number: "12", title: "Orders")
                    StatCard(number: "8", title: "Wishlist")
                    StatCard(number: "5", title: "Favorites")
                }
                .padding(.horizontal)
                
                // Action Buttons
                VStack(spacing: 16) {
                    ActionButton(title: "Edit Profile", icon: "pencil", color: .orange)
                    ActionButton(title: "Settings", icon: "gearshape.fill", color: .gray)
                    ActionButton(title: "Logout", icon: "arrowshape.turn.up.left", color: .red)
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: - Stat Card
struct StatCard: View {
    var number: String
    var title: String
    
    var body: some View {
        VStack {
            Text(number)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.orange)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Action Button
struct ActionButton: View {
    var title: String
    var icon: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 24)
            
            Text(title)
                .foregroundColor(.primary)
                .fontWeight(.medium)
            
            Spacer()
            
            if title != "Logout" {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    Group {
        ProfileView() // Normal tab view
        ProfileView()
            .presentationDetents([.medium, .large]) // Sheet presentation
    }
}
