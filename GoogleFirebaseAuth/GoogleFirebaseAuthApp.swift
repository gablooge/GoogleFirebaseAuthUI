//
//  GoogleFirebaseAuthApp.swift
//  GoogleFirebaseAuth
//
//  Created by Samsul Hadi on 15/11/21.
//

import SwiftUI
import Firebase

@main
struct GoogleFirebaseAuthApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
