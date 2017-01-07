//
//  AudioDetails.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/11/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class AudioDetails: UIViewController {

    var aTitle = String()
    var aLevel = String()
    var aAuthor = String()
    var aDescription = String()
    var audioCoverURL = String()
    var downloadPath = String()
    
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var audioAuthor: UILabel!
    @IBOutlet weak var audioLevel: UILabel!
    @IBOutlet weak var audioTitle: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    
    let loader = ActivityViewController(message: "loading...")
    let downloader = ActivityViewController(message: "downloading...")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadButton.layer.cornerRadius = 5
        downloadButton.layer.backgroundColor = UIColor.green.cgColor
        
        if !aTitle.isEmpty {
            audioTitle.text = aTitle
            audioLevel.text = aLevel
            audioAuthor.text = aAuthor
            descriptionText.text = aDescription
            coverImage.image = UIImage(named: "kids2")
        }
        
    }
    @IBAction func downloadAudio(_ sender: AnyObject) {
        
        print(self.downloadPath)
        self.present(downloader, animated: true, completion: nil)
        let downloadLink = self.downloadPath
        
        //downloading audio
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
                    
                    self.saveToRealm(title: self.aTitle, author: self.aAuthor, level: self.aLevel, summary: self.aDescription, filepath: "\(destinationURL)")
                }
                
        }

    }
    
    func saveToRealm(title:String, author:String, level:String,
                     summary:String, filepath:String){
        let audioModel = AudioModel()
        audioModel.title = title
        audioModel.author = author
        audioModel.level = level
        audioModel.summary = summary
        audioModel.filename = filepath
        
        
        let realm = try! Realm()
        
        try! realm.write(){
            print("writing====>>")
            realm.add(audioModel)
        }
        
        let audioModelRetrieve = realm.objects(AudioModel.self)
        print(audioModelRetrieve[0].filename)
        
    }
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
