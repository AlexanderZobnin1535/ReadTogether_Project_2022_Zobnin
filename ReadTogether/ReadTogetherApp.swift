//  App itself
//  Here app opens
//  ReadTogetherApp.swift
//  ReadTogether
//
//  Created by Александр on 17.12.2020.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

@main
struct ReadTogetherApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            FirstScreen()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        let db = Firestore.firestore()
        
        print(db)
        
        return true
    }
}
