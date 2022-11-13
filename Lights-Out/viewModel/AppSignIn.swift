//
//  AppleSignIn.swift
//  Wishing-Well
//
//  Created by McKiba Williams on 11/5/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn

@main
struct AppSignIn: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
     }
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])-> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
  
   
}

