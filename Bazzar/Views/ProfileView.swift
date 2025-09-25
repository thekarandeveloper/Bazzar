import SwiftUI
import AuthenticationServices
import GoogleSignIn
import FirebaseCore
import FirebaseAuth
import SwiftData

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @StateObject private var authManager = AuthenticationManager.shared
    
    @State private var showAppleReauthSheet = false
    @State private var showGoogleReauthSheet = false
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                Spacer().frame(height: 20)
                
                AvatarView()
                
                VStack(spacing: 14) {
                    NavigationLink {
                        OrdersView()
                    } label: {
                        ProfileActionRow(title: "Orders", icon: "bag.fill") {}
                    }
                    
                    NavigationLink {
                        WishlistView()
                    } label: {
                        ProfileActionRow(title: "Wishlist", icon: "heart.fill") {}
                    }
                    
                    NavigationLink {
                        AddressListView()
                    } label: {
                        ProfileActionRow(title: "Addresses", icon: "map.fill") {}
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                DeleteUserButton {
                    showDeleteConfirmation = true
                }
                .alert("Are you sure?", isPresented: $showDeleteConfirmation) {
                    Button("Cancel", role: .cancel) {}
                    Button("Delete", role: .destructive) {
                        Task {
                            await handleDelete()
                        }
                    }
                } message: {
                    Text("This will permanently delete your account, all data in Bazzar, and cannot be undone.")
                }
                
             
                
                LogoutButton {
                    Task {
                        await authManager.signOut()
                    }
                }
                Spacer()
            }
            .padding(.vertical, 20)
            .background(Color("backgroundColor").ignoresSafeArea())
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showAppleReauthSheet) {
                AppleReauthView { credential in
                    Task {
                        await deleteUser(with: credential)
                        showAppleReauthSheet = false
                    }
                }
            }
            .sheet(isPresented: $showGoogleReauthSheet) {
                GoogleReauthView { credential in
                    Task {
                        await deleteUser(with: credential)
                        showGoogleReauthSheet = false
                    }
                }
            }
        }
    }
    
    // MARK: - Handle Delete
    func handleDelete() {
        guard let user = authManager.currentUser else { return }
        
        switch authManager.signInMethod {
        case .apple:
            showAppleReauthSheet = true
        case .google:
            showGoogleReauthSheet = true
        case .none:
            print("⚠️ No sign-in method stored")
        }
    }
    
    // MARK: - Delete User Logic
    func deleteUser(with credential: AuthCredential) async {
        guard let user = authManager.currentUser else { return }
        do {
            // Reauthenticate
            try await user.reauthenticate(with: credential)
            
            // Delete Firestore data
            try await FirestoreManager.shared.db.collection("Users").document(user.uid).delete()
            
            // Delete FirebaseAuth
            try await user.delete()
            
            // Clear SwiftData
            let fetchRequest = FetchDescriptor<User>()
            let users = try context.fetch(fetchRequest)
            for u in users { context.delete(u) }
            try context.save()
            
            print("✅ User deleted")
            dismiss()
        } catch {
            print("❌ Failed: \(error.localizedDescription)")
        }
    }
}

// MARK: - Avatar View
struct AvatarView: View {
    @Query var user: [User]

    var personalInfo: User {
        user.first ?? User(id: "0", name: "User Name", email: "example@example.com", lastUpdated: Date())
    }

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.orange.opacity(0.8), .pink.opacity(0.6)],
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing))
                    .frame(width: 110, height: 110)
                    .shadow(color: .orange.opacity(0.3), radius: 8, x: 0, y: 4)

                Image(systemName: "person.fill")
                    .font(.system(size: 45))
                    .foregroundColor(.white)
            }

            Text(personalInfo.name)
                .font(.title2.bold())
                .foregroundStyle(.primary)

            Text("Joined \(personalInfo.lastUpdated.formatted(date: .abbreviated, time: .omitted))")
                .font(.callout)
                .foregroundStyle(.secondary)
        }
        .padding(.bottom, 8)
    }
}

// MARK: - Action Row
struct ProfileActionRow: View {
    var title: String
    var icon: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.15))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .foregroundColor(.orange)
            }

            Text(title)
                .foregroundColor(.primary)
                .font(.system(size: 16, weight: .semibold))

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray.opacity(0.6))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color("secondaryBackground"))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
}

// MARK: - Logout Button
struct LogoutButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.red.opacity(0.15))
                        .frame(width: 36, height: 36)
                    Image(systemName: "power")
                        .foregroundColor(.red)
                }

                Text("Logout")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.red)

                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                   
            )
        }
        .padding(.horizontal)
    }
}

// MARK: - Delete Button
struct DeleteUserButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.red.opacity(0.15))
                        .frame(width: 36, height: 36)
                    Image(systemName: "trash.fill")
                        .foregroundColor(.red)
                }

                Text("Delete Account")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.red)

                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                  
            )
        }
        .padding(.horizontal)
    }
}

// MARK: - Reauth Apple
struct AppleReauthView: View {
    var completion: (AuthCredential) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Reauthenticate with Apple")
                .font(.headline)
            
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                case .success(let authResults):
                    if let credential = authResults.credential as? ASAuthorizationAppleIDCredential,
                       let tokenData = credential.identityToken,
                       let tokenString = String(data: tokenData, encoding: .utf8) {
                        let firebaseCredential = OAuthProvider.appleCredential(
                            withIDToken: tokenString,
                            rawNonce: "",
                            fullName: credential.fullName
                        )
                        completion(firebaseCredential)
                    }
                case .failure(let error):
                    print("Apple reauth failed: \(error.localizedDescription)")
                }
            }
            .signInWithAppleButtonStyle(.black)
            .frame(height: 50)
            .padding()
        }
        .padding()
    }
}

// MARK: - Reauth Google
struct GoogleReauthView: View {
    var completion: (AuthCredential) -> Void
    
    var body: some View {
        Button("Sign in with Google to confirm") {
            Task {
                guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                let config = GIDConfiguration(clientID: clientID)
                guard let rootVC = UIApplication.shared.windows.first?.rootViewController else { return }
                
                let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootVC)
                guard let idToken = result.user.idToken?.tokenString else { return }
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: result.user.accessToken.tokenString)
                completion(credential)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .padding()
        .background(Color.orange)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

#Preview {
    ProfileView()
}
