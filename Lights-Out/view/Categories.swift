//
//  Categories.swift
//  Lights-Out
//
//  Created by McKiba Williams on 12/24/22.
//

import SwiftUI

struct Categories: View {
    
    let radiusSize: CGFloat = 15
    let cardHeight: CGFloat = 140
    let cardWidth:  CGFloat = 130
    
    
    var body: some View {
        
        HStack(alignment: .center, spacing:10) {
            VStack(alignment: .center, content: {
                Image("movie")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame( width: cardWidth, height: cardHeight)
                    .clipShape(RoundedRectangle(cornerRadius: radiusSize))
                Text("Movies").fontWeight(.bold).font(.subheadline)

            })
            
            VStack(alignment: .center, content: {
                Image("tv")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame( width: cardWidth, height: cardHeight)
                    .clipShape(RoundedRectangle(cornerRadius: radiusSize))
                Text("TV Shows").fontWeight(.bold).font(.subheadline)

            })
            
            VStack(alignment: .center, content: {
                Image("people")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame( width: cardWidth, height: cardHeight)
                    .clipShape(RoundedRectangle(cornerRadius: radiusSize))
                Text("People").fontWeight(.bold).font(.subheadline)

            })
        }.frame(height: 140).padding(.horizontal)
        
    }
}

struct Categories_Previews: PreviewProvider {
    static var previews: some View {
        Categories()
    }
}
