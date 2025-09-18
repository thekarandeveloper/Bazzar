//
//  HomeView.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//

import SwiftUI

struct HomeView: View{
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View{
        // Navbar
        CustomNavigationBarView(selectedTab: .home)
        .frame(height: 40)
        
        ScrollView(.vertical, showsIndicators: false){
            
            VStack(spacing: 20){
                
              
                // Categories Selection
                
                HStack{
                    Text("Categories")
                        .font(.headline)
                    Spacer()
                    Text("See All")
                        .font(.caption)
                }
                
                // Options Selection
                
                HStack(alignment: .center, spacing: 20){
                    
                    Text("All")
                        .font(.callout)
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    Text("Men")
                        .foregroundStyle(Color.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    Text("Women")
                        .foregroundStyle(Color.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    Text("Girls")
                        .foregroundStyle(Color.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
                
                
                // Banner Selection
                
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .frame(width: .infinity, height: 250)
                
                
                
                // Products Selection
                
                HStack{
                    Text("Popular Product")
                        .font(.headline)
                    Spacer()
                    Text("See All")
                        .font(.caption)
                }
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<10, id: \.self) { index in
                        NavigationLink(destination: ProductView()) {
                            ProductCardView()
                        }
                        .buttonStyle(PlainButtonStyle()) // removes default nav highlight
                    }
                    .frame(width: 160, height: 200)
                }
                
                
            }
        }
        
    }
    struct ProductCardView: View {
        var body: some View {
            VStack(spacing: 12) {
                Image("girlPhoto")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 150)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Cotton T-shirt")
                            .font(.headline)
                        HStack(spacing: 6) {
                            Text("$69.00")
                                .font(.caption)
                                .foregroundColor(.orange)
                            Text("$169.00")
                                .font(.caption2)
                                .strikethrough()
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    Button {
                        print("Bell pressed")
                    } label: {
                        Image(systemName: "bell.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
            }
            .frame(width: 160)
        }
    }
}
