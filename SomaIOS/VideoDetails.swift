//
//  VideoDetails.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/12/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class VideoDetails: UIViewController {

    @IBOutlet weak var videoLevel: UILabel!
    @IBOutlet weak var videoAuthor: UILabel!
    @IBOutlet weak var videoCover: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    
    var vTitle = String()
    var vLevel = String()
    var vAuthor = String()
    var vDescription = String()
    var videoCoverURL = String()
    var downloadPath = String()
    
    let loader = ActivityViewController(message: "loading...")
    let downloader = ActivityViewController(message: "downloading...")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !vTitle.isEmpty {
            videoTitle.text = vTitle
            videoLevel.text = vLevel
            videoAuthor.text = vAuthor
            //descriptionText.text = vDescription
            videoCover.image = UIImage(named: "kids2")
        }
    }

    @IBAction func downloadVideo(_ sender: AnyObject) {
        
        print(self.downloadPath)
        self.present(downloader, animated: true, completion: nil)
        let downloadLink = self.downloadPath
        
        //downloading
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        
        print("\(destination) file destination...\(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString) destination file two")
        
        let utilityQueue = DispatchQueue.global(qos: .utility)
        
        Alamofire.download(downloadLink.replacingOccurrences(of: " ", with: "%20"), to: destination)
            .downloadProgress(queue: utilityQueue) { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .response { response in
                print(response)
                
                self.dismiss(animated: true, completion: nil)
                
                if let destinationURL = response.destinationURL {
                    
                    print("destination file path \(response.destinationURL)")
                    
                    self.saveToRealm(title: self.vTitle, author: self.vAuthor, level: self.vLevel, summary: self.vDescription, filepath: "\(destinationURL)")
                }
                
        }

        
    }
    
    
    func saveToRealm(title:String, author:String, level:String,
                     summary:String, filepath:String){
        let videoModel = VideoModel()
        videoModel.title = title
        videoModel.author = author
        videoModel.level = level
        videoModel.summary = summary
        videoModel.filename = filepath
        
        
        let realm = try! Realm()
        
        try! realm.write(){
            print("writing====>>")
            realm.add(videoModel)
        }
        
        let videoModelRetrieve = realm.objects(VideoModel.self)
        print(videoModelRetrieve[0].filename)
        
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
   

}
