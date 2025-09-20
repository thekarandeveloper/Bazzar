//
//  CustomTabbar.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//


import SwiftUI

enum Tab{
    case home
    case categories
    case cart
    case account
}

struct CustomTabbar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack{
            tabButton(.home, icon: "house.fill", title: "Home")
            Spacer()
            tabButton(.categories, icon: "square.grid.2x2.fill", title: "Categories")
            Spacer()
            tabButton(.cart, icon: "heart", title: "Wishlist")
            Spacer()
            tabButton(.account, icon: "person.crop.circle.fill", title: "Account")
        }.padding()
            .background(Color.white)
    }
    
    func tabButton(_ tab: Tab, icon:String, title:String) -> some View {
        Button(action: {
            
            withAnimation(.spring()){
                selectedTab = tab
            }
            }){
            VStack{
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .bold))
                Text(title)
                    .font(.caption)
            }.foregroundColor(selectedTab == tab ? .orange : .gray)
        }
    }
    
}
