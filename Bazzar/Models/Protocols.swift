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
