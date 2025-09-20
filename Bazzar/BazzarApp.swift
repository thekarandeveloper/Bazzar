//
//  BazzarApp.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//

import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Configure Firebase at launch
        FirebaseApp.configure()
        return true
    }
}

@main
struct BazzarApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var cartManager = CartManager()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(cartManager)
            
        }.modelContainer(for: [User.self])
    }
    
    
    
    
}
