//
//  Protocols.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//


import Foundation
import FirebaseFirestore

protocol FirestoreModel: Codable, Identifiable{
    var id: String { get set}
    var lastUpdated: Date {get set}
}

class ProductImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    static func setImage(_ image: UIImage, for url: String) {
        shared.setObject(image, forKey: url as NSString)
    }
    
    static func getImage(for url: String) -> UIImage? {
        return shared.object(forKey: url as NSString)
    }
}
