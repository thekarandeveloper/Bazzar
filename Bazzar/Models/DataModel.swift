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


@Model
class User:FirestoreModel, Identifiable, Codable {
    @Attribute(.unique) var id: String   // Firebase UID
    var name: String
    var email: String
    var lastUpdated: Date = Date()
    
    // MARK: - Codable conformance
    enum CodingKeys: String, CodingKey {
        case id, name, email, lastUpdated
    }

    // MARK: - Custom init
    init(id: String, name: String, email: String, lastUpdated: Date = Date()) {
        self.id = id
        self.name = name
        self.email = email
        self.lastUpdated = lastUpdated
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.lastUpdated = try container.decode(Date.self, forKey: .lastUpdated)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(lastUpdated, forKey: .lastUpdated)
    }

  
}


struct Product: Identifiable, Codable {
    @DocumentID var id: String?  // For Firebase
    var name: String
    var category: String
    var price: Double
    var oldPrice: Double
    var imageUrl: String
    
    // Optional fields for app-local state
    var isInCart: Bool = false
    var isInWishlist: Bool = false
}
