//
//  Player.swift
//  Lights-Out
//
//  Created by McKiba Williams on 12/12/22.
//

import SwiftUI
import UIKit
import AVKit


class PlayerView: UIView {
 
    private let playerLayer = AVPlayerLayer()
    private var previewTimer: Timer?
    var previewLength: Double
    
    init(frame: CGRect, url: URL, previewLength: Double){
        self.previewLength = previewLength
        
        super.init(frame: frame)
        let player = AVPlayer(url:url)
        
        player.volume = 2
        player.play()
        
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.backgroundColor = UIColor.black.cgColor
        
        previewTimer = Timer.scheduledTimer(withTimeInterval: previewLength, repeats: false, block: { (timer) in
            player.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(1)))
        })
        
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        self.previewLength = 15
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
}

 
