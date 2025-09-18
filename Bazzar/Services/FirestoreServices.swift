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
        
    
        // MARK: - Real-time Sync
//    func listenUserTransactions(context: ModelContext) {
//        guard let uid = Auth.auth().currentUser?.uid else {
//            print("❌ No authenticated user found")
//            return
//        }
//        
//        let db = Firestore.firestore()
//        print("🔹 Listening for transactions for user: \(uid)")
//        
//        db.collection("transactions")
//          .whereField("userID", isEqualTo: uid)
//          .addSnapshotListener { snapshot, error in
//              
//              if let error = error {
//                  print("❌ Firestore listener error: \(error.localizedDescription)")
//                  return
//              }
//              
//              guard let docs = snapshot?.documents else {
//                  print("⚠️ No documents in snapshot")
//                  return
//              }
//              
//              print("📄 Received \(docs.count) documents from Firestore")
//              
//              for doc in docs {
//                  do {
//                      let remoteTx = try doc.data(as: Transaction.self)
//                      print("➡️ Fetched transaction from server: id=\(remoteTx.id), amount=\(remoteTx.amount), lastUpdated=\(remoteTx.lastUpdated)")
//                      
//                      if let localTx = try? context.fetch(FetchDescriptor<Transaction>(
//                          predicate: #Predicate { $0.id == remoteTx.id }
//                      )).first {
//                          
//                          if localTx.lastUpdated < remoteTx.lastUpdated {
//                              print("🔄 Updating local transaction: \(localTx.id)")
//                              context.delete(localTx)
//                              context.insert(remoteTx)
//                          } else {
//                              print("✅ Local transaction is up-to-date: \(localTx.id)")
//                          }
//                          
//                      } else {
//                          print("➕ Inserting new local transaction: \(remoteTx.id)")
//                          context.insert(remoteTx)
//                      }
//                      
//                  } catch {
//                      print("❌ Error decoding transaction: \(error.localizedDescription)")
//                  }
//              }
//              
//              do {
//                  try context.save()
//                  print("💾 Local context saved successfully")
//              } catch {
//                  print("❌ Error saving local context: \(error.localizedDescription)")
//              }
//          }
//    }
}

