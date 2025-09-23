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
    let db = Firestore.firestore()
    
    
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

extension FirestoreManager {
    
    // Delete Current User (Auth + Firestore + Local SwiftData)
    func deleteCurrentUser(context: ModelContext, authManager: AuthenticationManager) async {
        guard let user = Auth.auth().currentUser else { return }

        do {
            // 1. Reauthenticate first
            switch authManager.signInMethod {
            case .google:
                let credential = try await authManager.getGoogleCredential()
                try await user.reauthenticate(with: credential)
            case .apple:
                let credential = try await authManager.getAppleCredential() // MUST trigger UI
                try await user.reauthenticate(with: credential)
            case .none:
                print("⚠️ No sign-in method stored")
                return
            }

            // 2. Delete Firestore data
            try await FirestoreManager.shared.db.collection("Users").document(user.uid).delete()

            // 3. Delete from FirebaseAuth
            try await user.delete()

            // 4. Clear local data
            let fetchRequest = FetchDescriptor<User>()
            let users = try context.fetch(fetchRequest)
            for u in users { context.delete(u) }
            try context.save()

            print("✅ User deleted successfully")
        } catch {
            print("❌ Reauthentication or deletion failed: \(error)")
        }
    }
    // MARK: - Reauthentication
    private func reauthenticate(user: FirebaseAuth.User, provider: AuthenticationManager.SignInMethod, authManager: AuthenticationManager) async throws {
        switch provider {
        case .google:
            // Get fresh Google credential via AuthenticationManager
            let credential = try await authManager.getGoogleCredential()
            try await user.reauthenticate(with: credential)
        case .apple:
            // Get fresh Apple credential via AuthenticationManager
            let credential = try await authManager.getAppleCredential()
            try await user.reauthenticate(with: credential)
        }
    }
}
