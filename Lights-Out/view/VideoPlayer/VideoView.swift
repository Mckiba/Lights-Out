//
//  VideoView.swift
//  Lights-Out
//
//  Created by McKiba Williams on 12/12/22.
//

import SwiftUI
import UIKit
import AVKit


struct VideoView: UIViewRepresentable {
 
    var videoURL: URL
     var previewLength: Double
    
    
    func makeUIView(context: Context) -> UIView {
        return PlayerView(frame: .zero, url: videoURL, previewLength: previewLength)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    
}

struct VideoView_Previews: PreviewProvider {
    
    static var url:URL = URL(string: "https://www.youtube.com/watch?v=mkomfZHG5q4")!
    
    static var previews: some View {
        VideoView(videoURL: url, previewLength: 15)
    }
}
