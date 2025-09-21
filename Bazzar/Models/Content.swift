//
//  Content.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//
import Foundation

class DataManager {
    static let shared = DataManager()
    private init() {}
    
    let products: [Product] = [
        Product(id: "1", name: "Cotton T-shirt", category: "Men", price: 69.0, oldPrice: 169.0, imageUrl: "1"),
        Product(id: "2", name: "Summer Dress", category: "Women", price: 89.0, oldPrice: 179.0, imageUrl: "2"),
        Product(id: "3", name: "Girls Skirt", category: "Girls", price: 49.0, oldPrice: 99.0, imageUrl: "3"),
        Product(id: "4", name: "Men Hoodie", category: "Men", price: 99.0, oldPrice: 199.0, imageUrl: "4"),
        Product(id: "5", name: "Women Top", category: "Women", price: 79.0, oldPrice: 159.0, imageUrl: "5"),
        Product(id: "6", name: "Kids Shoes", category: "Girls", price: 39.0, oldPrice: 89.0, imageUrl: "6"),
        Product(id: "7", name: "Men Jacket", category: "Men", price: 149.0, oldPrice: 249.0, imageUrl: "7"),
        Product(id: "8", name: "Women Handbag", category: "Women", price: 129.0, oldPrice: 229.0, imageUrl: "8"),
        Product(id: "9", name: "Girls T-shirt", category: "Girls", price: 29.0, oldPrice: 69.0, imageUrl: "9"),
        Product(id: "10", name: "Men Sneakers", category: "Men", price: 89.0, oldPrice: 179.0, imageUrl: "3")
    ]
}
