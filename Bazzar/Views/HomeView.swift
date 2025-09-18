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
        
        ScrollView(.vertical, showsIndicators: false){
            
         
            VStack(spacing: 20){
                
                // Categories Selection
                
                HStack{
                    Text("Categories")
                        .font(.headline)
                    Spacer()
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
                
                ZStack(alignment: .bottomLeading) {
                          // Background image
                          Image("bannerPhoto") // replace with your banner image
                              .resizable()
                              .scaledToFill()
                              .frame(height: 250)
                              .clipped()
                              .cornerRadius(12)
                          
                          // Gradient overlay for text visibility
                          LinearGradient(
                              gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.4)]),
                              startPoint: .top,
                              endPoint: .bottom
                          )
                          .cornerRadius(12)
                          
                          // Optional text / CTA
                          VStack(alignment: .leading, spacing: 8) {
                              Text("Mega Sale!")
                                  .font(.title)
                                  .fontWeight(.bold)
                                  .foregroundColor(.white)
                              
                              Text("Up to 50% off on selected items")
                                  .font(.subheadline)
                                  .foregroundColor(.white)
                          }
                          .padding()
                      }
                      .frame(height: 250)
                      .shadow(radius: 3)
                      .padding(.horizontal)
                  }
                
                
                
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
                
                
        }.padding(0)
        
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

