import SwiftUI

struct CategoryView: View {
    
    let categories = [
        ("Men", "menPhoto"),
        ("Women", "womenPhoto"),
        ("Kids", "kidsPhoto"),
        ("Electronics", "electronicsPhoto"),
        ("Shoes", "shoesPhoto"),
        ("Accessories", "accessoryPhoto")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // Assuming you have all products
    let allProducts: [Product] = DataManager.shared.products
    
    var body: some View {
        // Navbar
        CustomNavigationBarView(selectedTab: .home)
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
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
                    .buttonStyle(PlainButtonStyle()) // taaki tap highlight na aaye
                }
            }
            .padding()
        }
      
    }
}

// MARK: - Category Card
struct CategoryCardView: View {
    var name: String
    var imageName: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(12)
                .shadow(radius: 3)
            
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .clipped()
                .cornerRadius(12)
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .cornerRadius(12)
            
            Text(name)
                .font(.headline)
                .foregroundColor(.white)
                .padding(8)
        }
        .frame(height: 160)
    }
}
