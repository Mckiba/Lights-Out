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
        
      //  let computedRating: Int = ((rating/10)*5)
        
        ZStack{
            HStack{
                ForEach(0 ..< 5, id:\.self) { item in
                    Image(systemName: "star")
                }
            }.overlay(
                HStack(alignment: .firstTextBaseline){
                    ForEach(0 ..< 3, id:\.self ) { item in
                        Image(systemName: "star.fill").foregroundColor(Color.orange)
                    }
                }
            )
        }
    }
}

struct StarFill_Previews: PreviewProvider {
    static var previews: some View {
        StarFill(rating: 7).preferredColorScheme(.dark)
    }
}
