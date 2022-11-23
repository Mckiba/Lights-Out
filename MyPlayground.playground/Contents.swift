//
//  SwiftUIView.swift
//  Lights-Out
//
//  Created by McKiba Williams on 11/18/22.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        
        VStack(alignment: .center){
            ZStack {
                
                
                
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 5))
                    .foregroundColor(.red)
                    .opacity(0.3)
                    .frame(width: 50)
                    
//
                Circle()
                    .trim(from: 0, to: 0.2)
                    .stroke(style: StrokeStyle(lineWidth: 5))
                    .frame(width: 50)
                    .foregroundColor(.red)
                     .rotationEffect(Angle(degrees: 360))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: true)
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
