import SwiftUI
import FirebaseAuth
import SwiftData

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack { // Wrap in NavigationStack for navigation
            VStack(spacing: 24) {
                
                Spacer().frame(height: 20)
                
                // Avatar + Name
                AvatarView()
                
                // Quick Actions
                VStack(spacing: 12) {
                    NavigationLink(destination: OrdersView()) {
                        ProfileActionRow(title: "Orders", icon: "bag.fill")
                    }
                    NavigationLink(destination: WishlistView()) {
                        ProfileActionRow(title: "Wishlist", icon: "heart.fill")
                    }
                    NavigationLink(destination: AddressListView()) {
                        ProfileActionRow(title: "Addresses", icon: "map.fill")
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Logout Button
                LogoutButton {
                    logout()
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.vertical, 20)
            .background(Color("backgroundColor").ignoresSafeArea())
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func logout() {
        Task { @MainActor in
            do {
                try Auth.auth().signOut()
                print("User logged out")
            } catch {
                print("❌ Error: \(error.localizedDescription)")
            }
            
            // Clear SwiftData
            let fetchRequest = FetchDescriptor<User>()
            do {
                let users = try context.fetch(fetchRequest)
                for user in users { context.delete(user) }
                try context.save()
                print("SwiftData cleared")
            } catch {
                print("❌ SwiftData error")
            }
            
            // Clear UserDefaults
            UserDefaults.standard.removeObject(forKey: "selectedCurrency")
            UserDefaults.standard.removeObject(forKey: "isDarkMode")
            UserDefaults.standard.removeObject(forKey: "notificationsEnabled")
            
            dismiss()
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

#Preview {
    ProfileView()
}
