//
//  DataModel.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//

import Foundation
import SwiftUI
import SwiftData
import FirebaseFirestore

// MARK: - User Model
@Model
class User: FirestoreModel, Identifiable, Codable {
    @Attribute(.unique) var id: String   // Firebase UID
    var name: String
    var email: String
    var lastUpdated: Date = Date()
    
    
    // Cart & Wishlist references
    var cart: [CartItem] = []
    var wishlist: [String] = [] // only product IDs for wishlist
    
    
    // RELATIONSHIP: One user → many addresses
    @Relationship var addresses: [Address] = []
        
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, lastUpdated, cart, wishlist
    }
    
    init(id: String, name: String, email: String, lastUpdated: Date = Date(), cart: [CartItem] = [], wishlist: [String] = []) {
        self.id = id
        self.name = name
        self.email = email
        self.lastUpdated = lastUpdated
        self.cart = cart
        self.wishlist = wishlist
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.lastUpdated = try container.decode(Date.self, forKey: .lastUpdated)
        self.cart = try container.decodeIfPresent([CartItem].self, forKey: .cart) ?? []
        self.wishlist = try container.decodeIfPresent([String].self, forKey: .wishlist) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(lastUpdated, forKey: .lastUpdated)
        try container.encode(cart, forKey: .cart)
        try container.encode(wishlist, forKey: .wishlist)
    }
}

// MARK: - Product Model
struct Product: Identifiable, Codable, Hashable {
    @DocumentID var id: String? = UUID().uuidString  // Firestore document ID
    var name: String
    var category: String
    var price: Double
    var oldPrice: Double
    var imageUrl: String
    var desc:String
    // Local-only fields
    var isInCart: Bool = false
    var isInWishlist: Bool = false
}

// MARK: - Cart Item Model
struct CartItem: Identifiable, Codable, Hashable {
    var id: String // same as product.id
    var product: Product
    var quantity: Int
    
    init(id: String, product: Product, quantity: Int = 1) {
        self.id = id
        self.product = product
        self.quantity = quantity
    }
}

// MARK: - Wishlist Item (optional, if you want more than productId)
struct WishlistItem: Identifiable, Codable, Hashable {
    var id: String // same as product.id
    var product: Product
    
    init(product: Product) {
        self.id = product.id ?? UUID().uuidString
        self.product = product
    }
}

// MARK: - Address Model

@Model
class Address {
    @Attribute(.unique) var id: String
    var name: String
    var phone: String
    var street: String
    var city: String
    var state: String
    var zip: String
    var country: String
    var createdAt: Date
    
    // RELATIONSHIP: Link to User
    @Relationship(inverse: \User.addresses) var user: User?

    init(id: String = UUID().uuidString,
         name: String,
         phone: String,
         street: String,
         city: String,
         state: String,
         zip: String,
         country: String,
         createdAt: Date = Date(),
         user: User? = nil) {
        self.id = id
        self.name = name
        self.phone = phone
        self.street = street
        self.city = city
        self.state = state
        self.zip = zip
        self.country = country
        self.createdAt = createdAt
        self.user = user
    }
}
