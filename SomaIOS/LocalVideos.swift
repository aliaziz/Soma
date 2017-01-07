//
//  LocalVideos.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/12/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import RealmSwift
import AVFoundation
import AVKit

class LocalVideos: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var songPath = String()
    var playerView = AVPlayer()
    var playerViewController = AVPlayerViewController()
    var videos_array = [String]()
    var videos_names = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchVideosFromDB()
        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bookshelf-bg-320.png")!)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos_array.count
        //return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! LocalVideoCollectionViewCell
        cell.image.image = UIImage(named: "kids2")
        cell.label.text = videos_names[indexPath.row]
        cell.image.layer.shadowColor = UIColor.black.cgColor
        cell.image.layer.shadowOffset = CGSize(width: 1, height: 1);
        cell.image.layer.shadowOpacity = 0.5;
        cell.image.layer.shadowRadius = 3.0;
        cell.image.clipsToBounds = false;

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "player", sender: self)
        var songPathNew = songPath.replacingOccurrences(of: "%20", with: " ")
        songPathNew = songPathNew.replacingOccurrences(of: "//", with: "/")
        
        //get video and play it
        let fileURL = URL(string:document(getvideoNameFromPath(path: self.videos_array[indexPath.row]))!)
        playerView = AVPlayer(url: fileURL!)
        playerViewController.player = playerView
        
        self.present(playerViewController, animated: true){
            self.playerViewController.player?.play()
        }

    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let indexPaths = self.collectionView!.indexPathsForSelectedItems!
//        let indexPath = indexPaths[0] as IndexPath
//        
//        let navView = segue.destination as! UINavigationController
//        let videoPlayer = navView.topViewController as! VideoPlayer
//        videoPlayer.songPath = document(getvideoNameFromPath(path: self.videos_array[indexPath.row]))!
//        
//    }
    
    func fetchVideosFromDB(){
        let localvideos = try! Realm().objects(VideoModel.self)
        
        for i in 0..<localvideos.count {
            videos_array.append(localvideos[i].filename as String)
            videos_names.append(localvideos[i].title as String)
            print("\(localvideos[i].filename ) ==> local videos")
        }
    }
    
    func getvideoNameFromPath(path: String)->String {
        let pdfLink = path
        
        let index2 = pdfLink.range(of: "/", options: .backwards)?.lowerBound
        
        let substring2 = pdfLink.substring(from: index2!)
        
        print(substring2)
        
        print("\(substring2) file path after removing pdf slashes")
        
        return substring2
    }
    
    fileprivate func document(_ name: String) -> String? {
        //Bundle.init(path: name)
        guard let documentURL = self.getvideosURL().appendingPathComponent(name)
            else { return nil }
        print(documentURL.path)
        
        return documentURL.path
    }
    
    func getvideosURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL as NSURL
    }

}
