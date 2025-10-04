//
//  RootView.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//
import SwiftUI
import FirebaseAuth

struct RootView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var showSplash = true
    @AppStorage("hasSkippedOnboarding") private var hasSkippedOnboarding = false
    @Environment(\.modelContext) private var context

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
            } else {
                if authManager.isAuthenticated {
                    ContentView()
                } else if hasSkippedOnboarding {
                    ContentView() 
                } else {
                    OnboardingView()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation { showSplash = false }
            }
            Auth.auth().addStateDidChangeListener { _, user in
                withAnimation {
                    authManager.isAuthenticated = user != nil
                }
            }
        }
    }
}
