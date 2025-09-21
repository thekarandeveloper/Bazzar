import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        TabView {
            
            // Home Tab
            NavigationStack {
                HomeView()
                    .padding(20)
                    .navigationBarBackButtonHidden(true)
                    .toolbar(.hidden, for: .tabBar) // hide tab bar
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            // Categories Tab
            NavigationStack {
                CategoryView()
                    .navigationBarBackButtonHidden(true)
                    .toolbar(.hidden, for: .tabBar) // hide tab bar
            }
            .tabItem {
                Label("Categories", systemImage: "square.grid.2x2.fill")
            }
            
            // Wishlist Tab
            NavigationStack {
                WishlistView()
                    .padding(20)
                    .navigationBarBackButtonHidden(true)
                    .toolbar(.hidden, for: .tabBar) // hide tab bar
            }
            .tabItem {
                Label("Wishlist", systemImage: "heart.fill")
            }
            
            // Profile Tab
            NavigationStack {
                ProfileView()
                    .padding(20)
                    .navigationBarBackButtonHidden(true)
                    .toolbar(.hidden, for: .tabBar) // hide tab bar
            }
            .tabItem {
                Label("Account", systemImage: "person.fill")
            }
        }
        .accentColor(.orange)
    }
}
