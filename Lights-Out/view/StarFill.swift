//
//  StarFill.swift
//  Lights-Out
//
//  Created by McKiba Williams on 12/11/22.
//

import SwiftUI

struct StarFill: View {
    
    @State var rating: Int
    
    init(rating: Int) {
        self.rating = rating
    }
    
    var body: some View {
        
        let computedRating: Int = ((rating/10)*5)
        
        ZStack(alignment: .leading){
            HStack{
                ForEach(0 ..< 5) { item in
                    Image(systemName: "star")
                }
            }.overlay(
                HStack(alignment: .firstTextBaseline){
                    ForEach(0 ..< Int(computedRating)) { item in
                        Image(systemName: "star.fill").foregroundColor(Color.yellow)
                    }
                }.opacity(1)
            )
        }
    }
}

struct StarFill_Previews: PreviewProvider {
    static var previews: some View {
        StarFill(rating: 7).preferredColorScheme(.dark)
    }
}
