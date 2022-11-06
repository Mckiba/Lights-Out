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
 
        ZStack{
            if (log_Status){
                Home()
            }
            else{ Login()}
        }

    }
    

}
 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
