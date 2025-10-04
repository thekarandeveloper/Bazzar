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
    @State private var showOnboarding = false
    @AppStorage("hasSkippedOnboarding") private var hasSkippedOnboarding = false
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @Environment(\.modelContext) private var context

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
            } else {
                ContentView()
                    .sheet(isPresented: $showOnboarding) {
                        OnboardingView()
                            
                    }
            }
        }
        .onAppear {
            // Handle splash screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplash = false
                    checkAuthenticationState()
                }
            }
            
            // Listen for auth state changes
            Auth.auth().addStateDidChangeListener { _, user in
                withAnimation {
                    authManager.isAuthenticated = user != nil
                    authManager.currentUser = user
                    checkAuthenticationState()
                }
            }
        }
        .onChange(of: authManager.isAuthenticated) { _, isAuth in
            checkAuthenticationState()
        }
        .onChange(of: hasSkippedOnboarding) { _, skipped in
            checkAuthenticationState()
        }
    }
    
    private func checkAuthenticationState() {
        // Show onboarding if:
        // 1. User is not authenticated AND
        // 2. User hasn't skipped onboarding AND
        // 3. User hasn't completed onboarding
        let shouldShowOnboarding = !authManager.isAuthenticated &&
                                   !hasSkippedOnboarding &&
                                   !hasCompletedOnboarding
        
        withAnimation {
            showOnboarding = shouldShowOnboarding
        }
    }
}
