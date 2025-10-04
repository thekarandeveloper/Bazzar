//
//  OnboardingView.swift
//  MoneyMate
//
//  Created by Karan Kumar on 17/09/25.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

struct OnboardingView: View {
    @State private var currentPage = 0
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var currentNonce: String? = nil
    @AppStorage("hasSkippedOnboarding") private var hasSkippedOnboarding = false
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    // Loading states
    @State private var isAppleSignInLoading = false
    @State private var isGoogleSignInLoading = false

    let images = ["First", "Second", "Third"]

    let titles = [
        "Discover Products You Love",
        "Best Shopping Experience",
        "Fast & Secure Checkout"
    ]

    let subtitles = [
        "Browse thousands of items across fashion, electronics, and more—all in one place.",
        "Add to cart, manage your wishlist, and shop with an experience designed for you.",
        "Enjoy quick payments and reliable delivery with our secure checkout process."
    ]
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    if hasSkippedOnboarding == true{
                        Button("Skip") {
                            hasSkippedOnboarding = true
                            dismiss()
                        }
                        .foregroundColor(.blue)
                        .padding()
                        .disabled(isAppleSignInLoading || isGoogleSignInLoading)
                    }
                   
                }
                
                Spacer().frame(maxHeight: 30)
                
                TabView(selection: $currentPage) {
                    ForEach(0..<titles.count, id: \.self) { index in
                        VStack(spacing: 20) {
                            Image(images[index])
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 300)
                                .foregroundColor(.blue)
                                .transition(.slide)
                                .animation(.easeInOut, value: currentPage)
                            
                            VStack {
                                Text(titles[index])
                                    .font(.title)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .transition(.opacity.combined(with: .scale))
                                    .animation(.easeInOut, value: currentPage)
                                
                                Text(subtitles[index])
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30)
                                    .transition(.opacity)
                                    .animation(.easeInOut, value: currentPage)
                            }
                        }
                        .tag(index)
                    }
                }
                .frame(maxHeight: 450)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                .onReceive(timer) { _ in
                    withAnimation {
                        currentPage = (currentPage + 1) % titles.count
                    }
                }
                
                HStack(spacing: 8) {
                    ForEach(0..<titles.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? Color.blue : Color("secondaryText").opacity(0.5))
                            .frame(width: currentPage == index ? 12 : 8,
                                   height: currentPage == index ? 12 : 8,
                                   alignment: .center)
                            .animation(.easeInOut, value: currentPage)
                    }
                }
                .padding(8)
                
                Spacer().frame(maxHeight: 60)
                
                // Apple Sign In Button with Loading
                ZStack {
                    SignInWithAppleButton(.signIn) { request in
                        let nonce = randomNonceString()
                        currentNonce = nonce
                        request.requestedScopes = [.fullName, .email]
                        request.nonce = sha256(nonce)
                    } onCompletion: { result in
                        isAppleSignInLoading = true
                        
                        switch result {
                        case .success(let authResults):
                            if let credential = authResults.credential as? ASAuthorizationAppleIDCredential,
                               let nonce = currentNonce {
                                Task {
                                    await authManager.signInWithApple(credential: credential, nonce: nonce)
                                    
                                    if authManager.isAuthenticated {
                                        await createUserIfNeeded()
                                        hasCompletedOnboarding = true
                                        dismiss()
                                    } else {
                                        // Authentication failed, reset loading
                                        isAppleSignInLoading = false
                                    }
                                }
                            } else {
                                isAppleSignInLoading = false
                            }
                        case .failure(let error):
                            print("Apple Sign-In failed: \(error.localizedDescription)")
                            isAppleSignInLoading = false
                        }
                    }
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .opacity(isAppleSignInLoading ? 0.6 : 1.0)
                    .disabled(isAppleSignInLoading || isGoogleSignInLoading)
                    
                    if isAppleSignInLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.2)
                    }
                }
                .padding(.horizontal, 20)
                
                // Google Sign In Button with Loading
                Button {
                    isGoogleSignInLoading = true
                    
                    Task {
                        await authManager.signInWithGoogle()
                        
                        if authManager.isAuthenticated {
                            await createUserIfNeeded()
                            hasCompletedOnboarding = true
                            dismiss()
                        } else {
                            // Authentication failed, reset loading
                            isGoogleSignInLoading = false
                        }
                    }
                } label: {
                    ZStack {
                        HStack {
                            if !isGoogleSignInLoading {
                                Image("googleLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .foregroundColor(.red)
                                    .font(.title2)
                            }
                            
                            Text(isGoogleSignInLoading ? "Signing in..." : "Sign in with Google")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 22)
                        .padding()
                        .opacity(isGoogleSignInLoading ? 0 : 1)
                        
                        if isGoogleSignInLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                .scaleEffect(1.2)
                        }
                    }
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color("secondaryText"), lineWidth: 1)
                    )
                    .cornerRadius(10)
                }
                .disabled(isAppleSignInLoading || isGoogleSignInLoading)
                .opacity((isAppleSignInLoading || isGoogleSignInLoading) ? 0.6 : 1.0)
                .padding(.horizontal, 20)
            }
        }
    }
 
    func createUserIfNeeded() async {
        guard let firebaseUser = authManager.currentUser else { return }
        
        let id = firebaseUser.uid
        let name = firebaseUser.displayName ?? "User"
        let email = firebaseUser.email ?? ""
        
        let user = User(id: id, name: name, email: email)
        
        await FirestoreManager.shared.save(user, in: "Users", context: context)
    }
}
