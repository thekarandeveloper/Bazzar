//
//  ProfileView.swift
//  MoneyMate
//
//  Created by Karan Kumar on 15/09/25.
//

import SwiftUI
import FirebaseAuth
import SwiftData
struct ProfileView: View{
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
   
    var body: some View{
     
        VStack {
            Spacer().frame(height: 20)
            avatarView()
            ProfileDetails()
            Spacer()
            LogoutButton{
                logout()
            }.padding()
        }.padding(20)
        
        
    }
    func logout() {
        Task { @MainActor in
            // Sign out from Firebase Auth
            do {
                try Auth.auth().signOut()
                print(" User Logged Out from Firebase")
            } catch let error as NSError {
                print("❌ Error signing out: \(error.localizedDescription)")
            }
            
            // Clear SwiftData (local persistence)
            
            let fetchRequest = FetchDescriptor<User>()
            do {
                let users = try context.fetch(fetchRequest)
                for user in users {
                    context.delete(user)
                }
                try context.save()
                print("SwiftData cleared")
            } catch {
                print("❌ Error clearing SwiftData: \(error)")
            }
            
            // Clear AppStorage / UserDefaults
            UserDefaults.standard.removeObject(forKey: "selectedCurrency")
            UserDefaults.standard.removeObject(forKey: "isDarkMode")
            UserDefaults.standard.removeObject(forKey: "notificationsEnabled")
            print("AppStorage cleared")
            
         
            // Update UI
//            isAuthenticated = false
        }
    }
}

struct avatarView: View{
    @Query var user: [User]
    
    var personalInfo: User {
           if let firstUser = user.first {
               return firstUser
           } else {
              
               return User(id: "0", name: "User Name", email: "example@example.com", lastUpdated: Date())
           }
       }
    var body: some View{
        
       
            VStack(spacing: 20){
                ZStack{
                   Circle()
                        .fill(Color("secondaryBackground"))
                        .frame(width: 100, height: 100)
                      

                    Image(systemName: "person.fill")
                        .font(.system(size: 34, weight: .medium))
                        .foregroundColor(.blue)
                }
                
                VStack {
                    Text("\(personalInfo.name)")
                        .font(.headline)
                    Text("Joined \(personalInfo.lastUpdated.formatted(date: .abbreviated, time: .omitted))")
                        .font(.callout)
                }
                
            }
            
        
        
       
        
       
    }
    
}

import SwiftUI

struct ProfileDetails: View {
    @Query var user: [User]
    
    var personalInfo: [(String, String)]{
        [
            ("Name", user.first?.name ?? "User Name"),
            ("Email", user.first?.email ?? "Unknown Email")
        ]
    }
    
    
    var body: some View {
        List {
            Section(header: Text("Personal Info").font(.headline)) {
                ForEach(personalInfo, id: \.0) { item in
                    HStack {
                        Text(item.0)
                            .foregroundColor(Color("Text"))
                        Spacer()
                        Text(item.1)
                            .foregroundColor(Color("Text"))
                            .fontWeight(.semibold)
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color("secondaryBackground"))
                }.background(Color("secondaryBackground"))
            }

        }
        .listStyle(.insetGrouped)
        
        .scrollContentBackground(.hidden)
       
    }
}


struct LogoutButton: View {
    var action: () -> Void  // closure to handle logout

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "power")
                    .foregroundColor(.red)
                Text("Logout")
                    .foregroundColor(.red)
                    .bold()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("secondaryBackground"))
            .cornerRadius(12)
        }
    }
    
   
    
}
