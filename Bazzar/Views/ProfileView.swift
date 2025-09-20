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
        // Navbar
        CustomNavigationBarView(selectedTab: .home)
        
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: 30) {
                
                // Header Banner with Profile Image
                ZStack(alignment: .bottom) {
                    LinearGradient(colors: [Color.orange.opacity(0.8), Color.orange.opacity(0.5)],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .frame(height: 220)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                    VStack(spacing: 8) {
                        Image("girlPhoto")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 5)
                        
                        Text("Alex Johnson")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("alex.johnson@example.com")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .offset(y: 50)
                }
                .padding(.bottom, 60)
                
                // Statistics Section
                HStack(spacing: 16) {
                    StatCard(number: "12", title: "Orders", color: .orange)
                    StatCard(number: "8", title: "Wishlist", color: .pink)
                    StatCard(number: "5", title: "Favorites", color: .purple)
                    StatCard(number: "3", title: "Cart", color: .green)
                }
              
                
                // Quick Actions
                VStack(spacing: 16) {
                    ActionButton(title: "Edit Profile", icon: "pencil", color: .orange)
                    ActionButton(title: "Manage Addresses", icon: "map.fill", color: .blue)
                    ActionButton(title: "Payment Methods", icon: "creditcard.fill", color: .green)
                    ActionButton(title: "Order History", icon: "bag.fill", color: .purple)
                    ActionButton(title: "Settings", icon: "gearshape.fill", color: .gray)
                    ActionButton(title: "Logout", icon: "arrowshape.turn.up.left", color: .red)
                }
                
                
                // Rewards / Loyalty Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Rewards & Loyalty")
                        .font(.headline)
                        .padding(.bottom, 4)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Points: 250")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Text("Next reward at 500 points")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "gift.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.orange)
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(12)
                }
              
                
                Spacer(minLength: 50)
            }
            .padding(.top, 20)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: - Stat Card
struct StatCard: View {
    var number: String
    var title: String
    var color: Color
    
    var body: some View {
        VStack {
            Text(number)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
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
