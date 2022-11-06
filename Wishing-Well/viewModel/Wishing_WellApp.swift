//
//  Wishing_WellApp.swift
//  Wishing-Well
//
//  Created by McKiba Williams on 6/30/22.
//

import SwiftUI

@main
struct Wishing_WellApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
