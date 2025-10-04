import SwiftUI

struct CategoryView: View {
    
    let categories = [
        ("Men", "girlPhoto"),
        ("Women", "girlPhoto"),
        ("Kids", "girlPhoto"),
        ("Electronics", "girlPhoto"),
        ("Shoes", "girlPhoto"),
        ("Accessories", "girlPhoto")
    ]
    
    // 3 equal columns with fixed spacing
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)
    
    let allProducts: [Product] = DataManager.shared.products
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                // Navbar
                CustomNavigationBarView(selectedTab: .home)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(categories, id: \.0) { category in
                            NavigationLink {
                                ProductListView(
                                    title: category.0,
                                    products: allProducts,
                                    filterCategory: category.0
                                )
                            } label: {
                                CategoryCardView(name: category.0, imageName: category.1)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                }
            }
            .padding(12)
        }
    }
}

// MARK: - Category Card
struct CategoryCardView: View {
    var name: String
    var imageName: String
    
    var body: some View {
        VStack(spacing: 0) {
            // Image top — fix height aur width grid ke according
            Image(imageName)
                .resizable()
                .frame(maxWidth: .infinity)   // stretch karega jitna cell ka width hai
                .frame(height: 80)           // fixed height
                .clipped()                   
            Spacer()
           
            Text(name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.white)
            Spacer().frame(height: 5)
        }
        .frame(height: 120)
        
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}
