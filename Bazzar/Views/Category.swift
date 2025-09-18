//
//  Category.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//


import SwiftUI

struct CategoryView: View {
    
    let categories = [
        ("Men", "menPhoto"),
        ("Women", "womenPhoto"),
        ("Kids", "kidsPhoto"),
        ("Electronics", "electronicsPhoto"),
        ("Shoes", "shoesPhoto"),
        ("Accessories", "accessoryPhoto")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        CustomNavigationBarView(selectedTab: .home)
        ScrollView {
//            LazyVGrid(columns: columns, spacing: 20) {
//                ForEach(categories, id: \.0) { category in
//                    NavigationLink(destination: CategoryDetailView(categoryName: "Men")) {
//                        CategoryCardView(name: category.0, imageName: category.1)
//                    }
//                    .buttonStyle(PlainButtonStyle())
//                }
//            }
//            .padding()
        }
        .navigationTitle("Categories")
    }
}

// MARK: - Category Card
struct CategoryCardView: View {
    var name: String
    var imageName: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 160)
                .clipped()
                .cornerRadius(12)
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .cornerRadius(12)
            
            Text(name)
                .font(.headline)
                .foregroundColor(.white)
                .padding(10)
        }
        .frame(height: 160)
        .shadow(radius: 3)
    }
}
