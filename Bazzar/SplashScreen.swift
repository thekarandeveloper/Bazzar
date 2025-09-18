//
//  SplashScreen.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//


import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)
            VStack {
                Image("AppLogo") // your logo
                    .resizable()
                    .frame(width: 150, height: 150)
                Text("Bazzar")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}
