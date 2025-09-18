//
//  Entity.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//

import SwiftData
import Foundation

@Model
class ProductEntity {
    @Attribute(.unique) var id: String
    @Attribute var name: String
    @Attribute var category: String
    @Attribute var price: Double
    @Attribute var oldPrice: Double
    @Attribute var imageUrl: String
    @Attribute var isInCart: Bool
    @Attribute var isInWishlist: Bool
    
    // Mapping from struct
    init(product: Product) {
      
        self.id = product.id ?? UUID().uuidString
        self.name = product.name
        self.category = product.category
        self.price = product.price
        self.oldPrice = product.oldPrice
        self.imageUrl = product.imageUrl
        self.isInCart = product.isInCart
        self.isInWishlist = product.isInWishlist
    }
    
    func toProduct() -> Product {
        return Product(
            id: self.id,
            name: self.name,
            category: self.category,
            price: self.price,
            oldPrice: self.oldPrice,
            imageUrl: self.imageUrl,
            isInCart: self.isInCart,
            isInWishlist: self.isInWishlist
        )
    }
}
