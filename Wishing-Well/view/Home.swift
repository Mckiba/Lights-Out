//
//  Home.swift
//  Wishing-Well
//
//  Created by McKiba Williams on 11/5/22.
//

import SwiftUI
import Firebase

struct Home: View {
    @AppStorage("log_status") var log_Status = false

    var body: some View {
        
        NavigationView{
            VStack{
                Text("Logged in succesfully using Apple Login")
                
                
                Button(action: {
                    DispatchQueue.global(qos: .background).async {
                        try? Auth.auth().signOut()
                    }
                    withAnimation(.easeInOut){
                        log_Status = false
                    }
                }, label: {
                    
                    Text("Log Out")
                        .fontWeight(.semibold)
                    
                })
            }
        }.navigationTitle("Home")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
