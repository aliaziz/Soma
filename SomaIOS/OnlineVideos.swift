//
//  OnlineVideos.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/12/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OnlineVideos: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }


    @IBOutlet weak var collectionView: UICollectionView!
    
    var videosTitle = [String]()
    var videoLevel = [String]()
    var videoAuthor = [String]()
    var videoSummary = [String]()
    var downloadPath = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bookshelf-bg-320.png")!)
        
        self.clearCollectionViewData()
        addOnlinevideosToView()
    }
    
    func clearCollectionViewData(){
        
        self.videosTitle.removeAll()
        self.collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! OnlineVideoCollectionViewCell
        
        cell.image.image = UIImage(named: "kids2")
        cell.image.layer.shadowColor = UIColor.black.cgColor
        cell.image.layer.shadowOffset = CGSize(width: 1, height: 1);
        cell.image.layer.shadowOpacity = 0.5;
        cell.image.layer.shadowRadius = 3.0;
        cell.image.clipsToBounds = false;
        
        if videosTitle.count > 0 {
            cell.label.text = videosTitle[(indexPath as NSIndexPath).row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "videoDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //so it handles parameters to be passed incase of any
        if segue.identifier == "videoDetails"
        {
            let indexPaths = self.collectionView!.indexPathsForSelectedItems!
            
            let indexPath = indexPaths[0] as IndexPath
            
            let navView = segue.destination as! UINavigationController
            let videoDetailsClass = navView.topViewController as! VideoDetails
            print(self.videosTitle[(indexPath as NSIndexPath).row])
            videoDetailsClass.vTitle = self.videosTitle[(indexPath as NSIndexPath).row]
            videoDetailsClass.vLevel = self.videoLevel[(indexPath as NSIndexPath).row]
            videoDetailsClass.vAuthor = self.videoAuthor[(indexPath as NSIndexPath).row]
            videoDetailsClass.vDescription = self.videoSummary[(indexPath as NSIndexPath).row]
            videoDetailsClass.downloadPath = self.downloadPath[(indexPath as NSIndexPath).row]
            
        }
    }
    func addOnlinevideosToView(){
        
        let token = "".token
        print("\(token) token ")
        
        Alamofire.request(Constants.urls().homeURL+"/getVideos?token="+token).responseJSON {
            response in
            print("begun alamofire...")
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    if let status = json["status"].bool{
                        if status {
                            if let results = json["results"].array{
                                for i in 0..<results.count {
                                    let title = results[i]["title"].string
                                    self.videosTitle.append(title!)
                                    self.videoAuthor.append(results[i]["author"].string!)
                                    self.videoSummary.append(results[i]["summary"].string!)
                                    self.videoLevel.append(results[i]["level"].string!)
                                    self.downloadPath.append(results[i]["url"].string!)
                                }
                            }
                            self.collectionView.reloadData()
                        }
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
