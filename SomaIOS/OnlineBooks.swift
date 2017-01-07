//
//  OnlineBooks.swift
//  SomaIOS
//
//  Created by ali ziwa on 9/21/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class OnlineBooks: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var imagesArray = [String]()
    var booksTitle = [String]()
    var bookLevel = [String]()
    var bookAuthor = [String]()
    var bookSummary = [String]()
    var downloadPath = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bookshelf-bg-320.png")!)
        
        self.clearCollectionViewData()
        addOnlineBooksToView()
    }

    func clearCollectionViewData(){
        
        self.imagesArray.removeAll()
        self.booksTitle.removeAll()
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! BookCellCollectionViewCell
        
        if imagesArray.count > 0{
            print("\(imagesArray.count)")
            print(imagesArray[(indexPath as NSIndexPath).row])
            
            if let URL = URL(string: imagesArray[(indexPath as NSIndexPath).row].replacingOccurrences(of: " ", with: "%20")) {
                cell.image.kf.setImage(with: URL, placeholder: UIImage(named: "blank"))
                cell.image.layer.shadowColor = UIColor.black.cgColor
                cell.image.layer.shadowOffset = CGSize(width: 1, height: 1);
                cell.image.layer.shadowOpacity = 0.5;
                cell.image.layer.shadowRadius = 3.0;
                cell.image.clipsToBounds = false;
            }
        }
        if booksTitle.count > 0 {
            cell.name.text = booksTitle[(indexPath as NSIndexPath).row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "bookDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //so it handles parameters to be passed incase of any
        if segue.identifier == "bookDetails"
            {
                let indexPaths = self.collectionView!.indexPathsForSelectedItems!
                
                let indexPath = indexPaths[0] as IndexPath
                
                let navView = segue.destination as! UINavigationController
                let bookDetailsClass = navView.topViewController as! BookDetails
                print(self.booksTitle[(indexPath as NSIndexPath).row])
                bookDetailsClass.bTitle = self.booksTitle[(indexPath as NSIndexPath).row]
                bookDetailsClass.bLevel = self.bookLevel[(indexPath as NSIndexPath).row]
                bookDetailsClass.bAuthor = self.bookAuthor[(indexPath as NSIndexPath).row]
                bookDetailsClass.bDescription = self.bookSummary[(indexPath as NSIndexPath).row]
                bookDetailsClass.bookCoverURL = self.imagesArray[(indexPath as NSIndexPath).row]
                bookDetailsClass.downloadPath = self.downloadPath[(indexPath as NSIndexPath).row]
            
            }
    }
    func addOnlineBooksToView(){
        
        let token = "".token
        print("\(token) token ")
        
        Alamofire.request(Constants.urls().homeURL+"/getBooks?token="+token).responseJSON {
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
                                    self.booksTitle.append(title!)
                                    self.imagesArray.append(results[i]["photo"].string!)
                                    self.bookAuthor.append(results[i]["author"].string!)
                                    self.bookSummary.append(results[i]["summary"].string!)
                                    self.bookLevel.append(results[i]["level"].string!)
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
