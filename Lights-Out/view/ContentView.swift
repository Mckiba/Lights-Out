//
//  ContentView.swift
//  Wishing-Well
//
//  Created by McKiba Williams on 6/30/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("log_status") var log_Status = false
    
    var body: some View {
//                if (!log_Status){
//                 Login()
//                }
        TabView {
            Home()
                .tabItem {
                    Label("", systemImage: "house.fill")
                }
            Upcoming()
                .tabItem {
                    Label("", systemImage: "magnifyingglass")
                }
            Upcoming()
                .tabItem {
                    Label("", systemImage: "calendar")
                }
            Upcoming()
                .tabItem {
                    Label("", systemImage: "bell")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() 
    }
}


