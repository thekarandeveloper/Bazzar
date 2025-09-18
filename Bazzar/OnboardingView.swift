//
//  OnboardingView.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//


import SwiftUI
import AuthenticationServices
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

struct OnboardingView: View {
    @Binding var isAuthenticated: Bool
    @State private var currentPage = 0
    @Environment(\.modelContext) private var context
    
    // Page Control Color
    
    let images = ["First", "Second", "Third"]
    let titles = ["Track Your Expenses", "Set Goals", "Analyze Your Spending"]

    let subtitles = [
        "Stay in control by recording every income and expense with ease.",
        "Define clear money goals and watch your progress step by step.",
        "Understand your habits with smart insights that guide better choices."
    ]
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack {
           
            Spacer().frame(maxHeight: 30)
            
            TabView(selection: $currentPage){
                ForEach(0..<titles.count, id:\.self){ index in
                    
                    VStack(spacing: 20) {
                        Image(images[index])
                            .resizable()
                            .scaledToFit() // keeps aspect ratio, no stretch
                            .frame(maxHeight: 300)
                            .foregroundColor(.orange)
                            .transition(.slide) // slide transition
                            .animation(.easeInOut, value: currentPage)
                        
                        VStack {
                            Text(titles[index])
                                .font(.title)
                                .bold()
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
                    .background(Color(red: 246/255, green: 246/255, blue: 246/255))
                    
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
                        .fill(currentPage == index ? Color.blue : Color.gray.opacity(0.5))
                        .frame(width: currentPage == index ? 12 : 8, height: currentPage == index ? 12: 8, alignment: .center).animation(.easeInOut, value:currentPage)
                    
                }
            }.padding(8)
            
            
            Spacer().frame(maxHeight: 60)
            
            
            
            // Apple Sign In Button
            SignInWithAppleButton(.signIn){ request in
                request.requestedScopes = [.fullName, .email]
                
            } onCompletion: { result in
                print(result)
            }.signInWithAppleButtonStyle(.black)
                .frame(height: 50)
                .frame(maxWidth: .infinity) // full width
                .padding(.horizontal, 20)
            
            
            
            // 🔹 Google Sign In
            Button {
                signInWithGoogle()
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
                    RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.gray, lineWidth: 1)
                )
                .cornerRadius(10)
                
            }
            .padding(.horizontal, 20)
        }
       
        
    }
    func signInWithGoogle() {
        // 1. Get the clientID from Firebase config (GoogleService-Info.plist)
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // 2. Create a Google Sign-In configuration using that clientID
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // 3. Get the current app window’s root ViewController (needed to present Google’s sign-in UI)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else {
            return
        }

        // 4. Start the Google Sign-In flow
        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { signInResult, error in
            // 5. Handle errors if Google sign-in fails
            if let error = error {
                print("Google Sign-In failed: \(error.localizedDescription)")
                return
            }

            // 6. Get the signed-in Google user and tokens
            guard let user = signInResult?.user,
                  let idToken = user.idToken?.tokenString else { return }

            let accessToken = user.accessToken.tokenString

            // 7. Convert Google tokens into Firebase credentials
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: accessToken)

            // 8. Sign in to Firebase with those credentials
            Auth.auth().signIn(with: credential) { result, error in
                // 9. Handle Firebase errors
                if let error = error {
                    print("Firebase Sign-In failed: \(error.localizedDescription)")
                    return
                }

                guard let user = result?.user else { return }
                let uid = user.uid
                let email = user.email ?? ""
                let name = user.displayName ?? ""
               
                
                
                isAuthenticated = true
                
                Task{
                    await createUser(id: uid, name: name, email: email)
                }
                
                // 10. Success! User is now authenticated with Firebase
                print("User signed in with Google: \(result?.user.uid ?? "")")
                
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

