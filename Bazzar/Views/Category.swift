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
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // Assuming you have all products
    let allProducts: [Product] = DataManager.shared.products
    
    var body: some View {
        
        ZStack{
            Color("backgroundColor").ignoresSafeArea()
            VStack{
                
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
                            .buttonStyle(PlainButtonStyle()) 
                        }
                    }
                   
                }
              
            }.padding(20)
            
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
                
            VStack(alignment: .center,spacing: 10){
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 50)
                    .clipped()
                    .cornerRadius(12)
                
                Text(name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(8)
            }
        
        }
        .frame(height: 160)
    }
}
