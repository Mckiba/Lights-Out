//
//  StarFill.swift
//  Lights-Out
//
//  Created by McKiba Williams on 12/11/22.
//

import SwiftUI

struct StarFill: View {
    
    @State var rating: Int
    
    var computedRating: Double
    var filledStarCount: Double
    var isHalfStar: Int
    var emptyStarCount: Int
    
    init(rating: Int) {
        self.rating = rating
        
        //Rating received was on a scale of 1 - 10, Converted it to a scale of 1 - 5
        self.computedRating = (Double(rating) / 10) * 5
        
        //Calculate how many filled stars I'll need
        self.filledStarCount = floor(computedRating)
        
        //if there is any remainder from computed rating I'll neeed an half star
        self.isHalfStar = computedRating.truncatingRemainder(dividingBy: 1.0) == 0.5 ? 1 : 0
        
        //Calculates number of empty stars to render
        self.emptyStarCount = 5 - (Int(self.filledStarCount) + self.isHalfStar)
    }
    
    var body: some View {
        HStack {
            ForEach(0 ..< Int(filledStarCount), id: \.self) { item in
                Image(systemName: "star.fill")
            }
            ForEach(0 ..< Int(isHalfStar), id: \.self) { item in
                Image(systemName: "star.leadinghalf.filled")
            }
            ForEach(0 ..< Int(emptyStarCount), id:\.self) { item in
                Image(systemName: "star")
            }
        }
    }
}


struct StarFill_Previews: PreviewProvider {
    static var previews: some View {
        StarFill(rating: 9).preferredColorScheme(.dark)
    }
}
