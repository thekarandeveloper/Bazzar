//
//  HomeView.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//

import SwiftUI

struct HomeView: View{

//    @Binding var searchtext: String
    
    var body: some View{
        ScrollView(.vertical){
            
            VStack(spacing: 20){
               
                // Navbar
                
                HStack {
                    
                    // Left Icon
                    Button(action: {
                        print("Button pressed")
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
                .frame(height: 50)
               
                // Search Bar
                
                HStack(spacing: 12) {
                    // Search Bar 80%
                    HStack {
                        Image(systemName: "magni")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .padding(.leading, 8)

                        Text("Search")
                            .font(.caption)

                      Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                    // Button 20%
                    Button {
                        print("Button pressed")
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(8)
                            .foregroundColor(.orange)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                  
                }
                .frame(height: 40)
               
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
                
                
                VStack(spacing: 20) {
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
                            HStack {
                                Text("$69.00")
                                    .font(.caption)
                                Text("$169.00")
                                    .font(.caption2)
                                    .strikethrough() // optional for old price
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
                .frame(width: 160, height: 200)
            }
          
           
        }
    }
}

#Preview {
    HomeView() // provide constant binding
}
