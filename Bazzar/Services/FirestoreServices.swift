//
//  FirestoreServices.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//


import SwiftUI
import Firebase
import FirebaseFirestore
import SwiftData
import FirebaseAuth
@MainActor
class FirestoreManager {
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()
    
    private init() {}
    
    // Mark: - Create / Update
    
    func save<T: FirestoreModel & PersistentModel>(_ model: T, in collection: String, context: ModelContext) async{
        do{
            
            // Save on Server
            let data = try Firestore.Encoder().encode(model)
            try await db.collection(collection).document(model.id).setData(data)
            
            
            // Save Locally
            context.insert(model)
            try? context.save()
        } catch {
            print("Error saving: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Read
    
    func fetch<T: FirestoreModel & PersistentModel>(_ type: T.Type, from collection: String, context: ModelContext) async -> [T] {
        do{
            let snapshot = try await db.collection(collection).getDocuments()
            let models = try snapshot.documents.compactMap{doc in
                try doc.data(as: T.self)
            }
            
            
            // Save Locally
            models.forEach{context.insert($0)}
            try? context.save()
            return models
        } catch {
            print("Error fetching: \(error.localizedDescription)")
            return []
        }
    }
    // MARK: - Delete
        func delete<T: FirestoreModel & PersistentModel>(_ model: T, from collection: String, context: ModelContext) async {
            do {
                try await db.collection(collection).document(model.id).delete()
                context.delete(model)
                try? context.save()
            } catch {
                print("❌ Error deleting: \(error.localizedDescription)")
            }
        }
        
    
     // Real Time Sync
    
}

