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

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                Spacer().frame(height: 20)
                
                AvatarView()
                
                VStack(spacing: 12) {
                    ProfileActionRow(title: "Orders", icon: "bag.fill")
                    ProfileActionRow(title: "Wishlist", icon: "heart.fill")
                    ProfileActionRow(title: "Addresses", icon: "map.fill")
                }
                .padding(.horizontal)
                
                Spacer()
                
                DeleteUserButton {
                    handleDelete()
                }
                
                Spacer()
                LogoutButton{
                    Task{
                        await authManager.signOut()
                    }
                    
                }
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
                    .fill(Color("secondaryBackground"))
                    .frame(width: 100, height: 100)
                Image(systemName: "person.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
            }

            Text(personalInfo.name)
                .font(.title2)
                .fontWeight(.bold)
            Text("Joined \(personalInfo.lastUpdated.formatted(date: .abbreviated, time: .omitted))")
                .font(.callout)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Action Row
struct ProfileActionRow: View {
    var title: String
    var icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .frame(width: 28)
            Text(title)
                .foregroundColor(.primary)
                .fontWeight(.medium)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color("secondaryBackground"))
        .cornerRadius(12)
    }
}

// MARK: - Logout Button
struct LogoutButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "power")
                    .foregroundColor(.red)
                Text("Logout")
                    .foregroundColor(.red)
                    .bold()
                Spacer()
            }
            .padding()
            .background(Color("secondaryBackground"))
            .cornerRadius(12)
        }
    }
}
struct DeleteUserButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                Text("Delete Account")
                    .foregroundColor(.red)
                    .bold()
                Spacer()
            }
            .padding()
            .background(Color("secondaryBackground"))
            .cornerRadius(12)
        }
    }
}

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
                            rawNonce: "", // use nonce if you used during login
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
