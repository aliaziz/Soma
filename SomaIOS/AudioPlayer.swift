//
//  AudioPlayer.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/11/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import AVFoundation


class AudioPlayer: UIViewController {
    
    @IBOutlet weak var back: UIBarButtonItem!
    @IBOutlet weak var stopSong: UIButton!
    @IBOutlet weak var viewLayer: UIView!
    
    var player:AVAudioPlayer = AVAudioPlayer()
    var songPath = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            try player = AVAudioPlayer(contentsOf: URL(string: songPath)!)
        }catch{
            //error
        }
        
        viewLayer.layer.cornerRadius = 5
        
    }
    
    @IBAction func previous(_ sender: AnyObject) {
    }
    @IBAction func playSong(_ sender: AnyObject) {
        player.play()
    }
    @IBAction func nextSong(_ sender: AnyObject) {
    }
    @IBAction func restartSong(_ sender: AnyObject) {
        player.currentTime = 0
    }
    @IBAction func stopSongButton(_ sender: AnyObject) {
        player.stop()
    }
 
    @IBAction func dismiss(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
