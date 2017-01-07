//
//  OnlineAudios.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/11/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OnlineAudios: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    @IBOutlet weak var collectionView: UICollectionView!
    var audiosTitle = [String]()
    var audioLevel = [String]()
    var audioAuthor = [String]()
    var audioSummary = [String]()
    var downloadPath = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bookshelf-bg-320.png")!)
        
        self.clearCollectionViewData()
        addOnlineAudiosToView()
    }
    
    func clearCollectionViewData(){
        
        self.audiosTitle.removeAll()
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return audiosTitle.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "audioCell", for: indexPath) as! OnlineAudioCollectionViewCell
        
        cell.image.image = UIImage(named: "kids2")
        cell.image.layer.shadowColor = UIColor.black.cgColor
        cell.image.layer.shadowOffset = CGSize(width: 1, height: 1);
        cell.image.layer.shadowOpacity = 0.5;
        cell.image.layer.shadowRadius = 3.0;
        cell.image.clipsToBounds = false;
        
        if audiosTitle.count > 0 {
            cell.label.text = audiosTitle[(indexPath as NSIndexPath).row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "audioDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //so it handles parameters to be passed incase of any
        if segue.identifier == "audioDetails"
        {
            let indexPaths = self.collectionView!.indexPathsForSelectedItems!
            
            let indexPath = indexPaths[0] as IndexPath
            
            let navView = segue.destination as! UINavigationController
            let audioDetailsClass = navView.topViewController as! AudioDetails
            print(self.audiosTitle[(indexPath as NSIndexPath).row])
            audioDetailsClass.aTitle = self.audiosTitle[(indexPath as NSIndexPath).row]
            audioDetailsClass.aLevel = self.audioLevel[(indexPath as NSIndexPath).row]
            audioDetailsClass.aAuthor = self.audioAuthor[(indexPath as NSIndexPath).row]
            audioDetailsClass.aDescription = self.audioSummary[(indexPath as NSIndexPath).row]
            audioDetailsClass.downloadPath = self.downloadPath[(indexPath as NSIndexPath).row]
            
        }
    }
    func addOnlineAudiosToView(){
        
        let token = "".token
        print("\(token) token ")
        
        Alamofire.request(Constants.urls().homeURL+"/getAudios?token="+token).responseJSON {
            response in
            
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
                                    self.audiosTitle.append(title!)
                                    self.audioAuthor.append(results[i]["author"].string!)
                                    self.audioSummary.append(results[i]["summary"].string!)
                                    self.audioLevel.append(results[i]["level"].string!)
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
