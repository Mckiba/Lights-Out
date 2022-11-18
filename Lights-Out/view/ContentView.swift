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
    @AppStorage("log_status") var log_Status = true
    
    var body: some View {
//        if (!log_Status){
//            Login()
//        }else {
            TabView {
                Home()
                    .tabItem {
                        Label("", systemImage: "house.fill")
                    }
                Home()
                    .tabItem {
                        Label("", systemImage: "magnifyingglass")
                    }
                Home()
                    .tabItem {
                        Label("", systemImage: "calendar")
                    }
            }.edgesIgnoringSafeArea(.vertical).colorScheme(.dark)
        }
//    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


