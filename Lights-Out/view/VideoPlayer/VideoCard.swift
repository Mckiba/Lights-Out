//
//  VideoCard.swift
//  Lights-Out
//
//  Created by McKiba Williams on 12/12/22.
//

import SwiftUI

struct VideoCard: View {
    
    @State var videoURL:URL
    @State var showPlayIcon:Bool
    var previewLength:Double
    
    var body: some View {
        ZStack {
            VideoView(videoURL: videoURL, previewLength: previewLength)
            if showPlayIcon {
                Image(systemName: "play.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(minWidth: 20, idealWidth: 40, maxWidth: 40, minHeight: 20, idealHeight: 40, maxHeight: 40, alignment: .center)
                .foregroundColor(Color.white)
            }
            
        }.ignoresSafeArea()
    }
}

struct VideoCard_Previews: PreviewProvider {
    
    static let url = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")!
    
    static var previews: some View {
        VideoCard(videoURL: url, showPlayIcon: true, previewLength: 20)
    }
}
