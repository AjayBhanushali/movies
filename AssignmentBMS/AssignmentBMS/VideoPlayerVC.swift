//
//  VideoPlayerVC.swift
//  AssignmentBMS
//
//  Created by D2k on 17/10/20.
//  Copyright © 2020 Ajay Bhanushali. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerVC: UIViewController, AVPlayerViewControllerDelegate {
    
    var url = "https://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVideoPlayer()
    }
    
    // MARK:- Custom Private Methods
    private func configureVideoPlayer() {
        guard let url = URL(string: url) else {
                    return
                }
                // Create an AVPlayer, passing it the HTTP Live Streaming URL.
                let player = AVPlayer(url: url)
                let controller = AVPlayerViewController()
                controller.allowsPictureInPicturePlayback = true
                controller.player = player
                present(controller, animated: true) {
                    controller.player?.play()
                }
    }
    
}

