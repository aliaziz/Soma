//
//  VideoPlayer.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/12/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayer: UIViewController,AVPlayerViewControllerDelegate  {
    var songPath = String()
    var playerView = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        
        var songPathNew = songPath.replacingOccurrences(of: "%20", with: " ")
        songPathNew = songPathNew.replacingOccurrences(of: "//", with: "/")
        
        //get video and play it
        let fileURL = URL(string:songPath)
        playerView = AVPlayer(url: fileURL!)
        playerViewController.player = playerView
        
        self.present(playerViewController, animated: true){
            self.playerViewController.player?.play()
        }
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}
