//
//  AppleSignIn.swift
//  Wishing-Well
//
//  Created by McKiba Williams on 11/5/22.
//

import SwiftUI
import Firebase

struct AppleSignIn: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var
    delegate
    var body: some Scene {
      WindowGroup {
          ContentView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

