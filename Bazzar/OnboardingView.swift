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
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var currentNonce: String? = nil
    @AppStorage("hasSkippedOnboarding") private var hasSkippedOnboarding = false

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
        
        ZStack{
            Color("backgroundColor")
                .ignoresSafeArea()
            VStack {
                HStack {
                       Spacer()
                    
                    if !hasSkippedOnboarding{
                        Button("Skip") {
                            hasSkippedOnboarding = true
                           
                        }
                        .foregroundColor(.blue)
                        .padding()
                    }
                      
                   }
                Spacer().frame(maxHeight: 30)
                
                TabView(selection: $currentPage){
                    ForEach(0..<titles.count, id:\.self){ index in
                        
                        VStack(spacing: 20) {
                            Image(images[index])
                                .resizable()
                                .scaledToFit() // keeps aspect ratio, no stretch
                                .frame(maxHeight: 300)
                                .foregroundColor(.blue)
                                .transition(.slide) // slide transition
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
                .onReceive(timer){ _ in
                    withAnimation{
                        currentPage = (currentPage + 1) % titles.count
                    }
                    
                }
                
                HStack(spacing: 8){
                    ForEach(0..<titles.count, id:\.self){ index in
                        
                        Circle()
                            .fill(currentPage == index ? Color.blue : Color("secondaryText").opacity(0.5))
                            .frame(width: currentPage == index ? 12 : 8, height: currentPage == index ? 12: 8, alignment: .center).animation(.easeInOut, value:currentPage)
                        
                    }
                }.padding(8)
                
                
                Spacer().frame(maxHeight: 60)
                
                
                
                // Apple Sign In Button
                SignInWithAppleButton(.signIn) { request in
                                let nonce = randomNonceString()
                                currentNonce = nonce
                                request.requestedScopes = [.fullName, .email]
                                request.nonce = sha256(nonce)
                            } onCompletion: { result in
                                switch result {
                                case .success(let authResults):
                                    if let credential = authResults.credential as? ASAuthorizationAppleIDCredential,
                                       let nonce = currentNonce {
                                        Task {
                                            await authManager.signInWithApple(credential: credential, nonce: nonce)
                                        }
                                    }
                                case .failure(let error):
                                    print("Apple Sign-In failed: \(error.localizedDescription)")
                                }
                            }
                .signInWithAppleButtonStyle(.black)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                
                
                
                // 🔹 Google Sign In
                Button {
                    Task {
                                        await authManager.signInWithGoogle()
                                    }
                } label: {
                    HStack {
                        Image("googleLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                            .foregroundColor(.red)
                            .font(.title2)
                        Text("Sign in with Google")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 22) // full width
                    .padding()
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color("secondaryText"), lineWidth: 1)
                    )
                    .cornerRadius(10)
                    
                }
                .padding(.horizontal, 20)
            }
           
        }
      
        
    }
 
    func createUser(id: String, name: String, email: String) async {
       
        
        let user = User(id: id, name: name, email: email)
        
        
        Task{
            await FirestoreManager.shared.save(user, in: "Users", context: context)
        }
      
    }
    
}

