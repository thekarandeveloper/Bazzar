//
//  AuthenticationManager.swift
//  Bazzar
//
//  Created by Karan Kumar on 23/09/25.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices
import FirebaseCore

@MainActor
class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()
    
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: FirebaseAuth.User? = nil
    // New property to track which service was used
       @Published var signInMethod: SignInMethod? = nil
    @State private var currentNonce: String? = nil
    
       
       enum SignInMethod: String {
           case google
           case apple
       }
init() {
        self.currentUser = Auth.auth().currentUser
        self.isAuthenticated = currentUser != nil
        self.signInMethod = nil
    }
    
    // MARK: - Sign in with Google
    func signInWithGoogle() async {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else { return }

        do {
            let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootVC)
            guard let idToken = signInResult.user.idToken?.tokenString else { return }
            let accessToken = signInResult.user.accessToken.tokenString

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            let result = try await Auth.auth().signIn(with: credential)
            
            self.currentUser = result.user
            self.isAuthenticated = true
            self.signInMethod = .google
            print("Google sign-in successful: \(result.user.uid)")
        } catch {
            print("Google sign-in failed: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Sign in with Apple
    func signInWithApple(credential: ASAuthorizationAppleIDCredential, nonce: String) async {
        guard let identityToken = credential.identityToken,
              let tokenString = String(data: identityToken, encoding: .utf8) else {
            print("Unable to fetch identity token")
            return
        }
        
        let firebaseCredential = OAuthProvider.appleCredential(
            withIDToken: tokenString,
            rawNonce: nonce,
            fullName: credential.fullName
        )
        
        do {
            let result = try await Auth.auth().signIn(with: firebaseCredential)
            self.currentUser = result.user
            self.isAuthenticated = true
            self.signInMethod = .apple
            print("Apple sign-in successful: \(result.user.uid)")
        } catch {
            print("Apple sign-in failed: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Manager
    
    func getGoogleCredential() async throws -> AuthCredential {
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                throw NSError(domain: "GoogleSignIn", code: 1, userInfo: [NSLocalizedDescriptionKey: "Missing clientID"])
            }
            let config = GIDConfiguration(clientID: clientID)
            
            return try await withCheckedThrowingContinuation { continuation in
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let rootVC = windowScene.windows.first?.rootViewController else {
                    continuation.resume(throwing: NSError(domain: "GoogleSignIn", code: 2, userInfo: [NSLocalizedDescriptionKey: "No root view controller"]))
                    return
                }
                
                GIDSignIn.sharedInstance.signIn(withPresenting: rootVC, hint: nil) { result, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }
                    
                    guard let user = result?.user,
                          let idToken = user.idToken?.tokenString else {
                        continuation.resume(throwing: NSError(domain: "GoogleSignIn", code: 3, userInfo: nil))
                        return
                    }
                    
                    let accessToken = user.accessToken.tokenString
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
                    continuation.resume(returning: credential)
                }
            }
        }

        // MARK: - Get fresh Apple credential
    private var lastAppleCredential: OAuthCredential? = nil
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                guard let identityToken = appleIDCredential.identityToken,
                      let tokenString = String(data: identityToken, encoding: .utf8) else { return }
                
                let credential = OAuthProvider.appleCredential(
                    withIDToken: tokenString,
                    rawNonce: currentNonce ?? "",
                    fullName: appleIDCredential.fullName
                )
                lastAppleCredential = credential
            }
        }

        func getAppleCredential() async throws -> AuthCredential {
            guard let credential = lastAppleCredential else {
                throw NSError(domain: "AppleSignIn", code: 1, userInfo: [NSLocalizedDescriptionKey: "Apple reauth requires user interaction"])
            }
            return credential
        }
    
    // MARK: - Sign out
    func signOut() async {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            self.isAuthenticated = false
            self.signInMethod = .google
        } catch {
            print("Sign-out error: \(error.localizedDescription)")
        }
    }
}
