//
//  BookDetails.swift
//  SomaIOS
//
//  Created by ali ziwa on 9/26/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import AlertKit
import Alamofire
import Realm
import RealmSwift
import Kingfisher

class BookDetails: UIViewController {

    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var addToLibrary: UIButton!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookLevel: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    var bTitle = ""
    var bAuthor = String()
    var bLevel = String()
    var bDescription = String()
    var bookCoverURL = String()
    var downloadPath = String()
    
    //loader
    let loader = ActivityViewController(message: "loading...")
    let downloader = ActivityViewController(message: "downloading...")
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.backgroundView.layer.cornerRadius = 5
            self.addToLibrary.layer.cornerRadius = 5
            self.addToLibrary.layer.borderColor = UIColor.green.cgColor
            self.bookCover.layer.cornerRadius = 5
            self.bookCover.layer.borderColor = UIColor.green.cgColor
        
        if !bookCoverURL.isEmpty{
            if let URL = URL(string: bookCoverURL.replacingOccurrences(of: " ", with: "%20")) {
                bookCover.kf.setImage(with: URL, placeholder: UIImage(named: "blank"))
            }
        }
        if !bTitle.isEmpty {
            bookTitle.text = bTitle
            bookAuthor.text = "Author: \(bAuthor)"
            bookLevel.text = "Level: \(bLevel)"
            bookDescription.text = bDescription
        }
    }

    @IBAction func addToLibraryAction(_ sender: AnyObject) {
        
        print(self.downloadPath)
        self.present(downloader, animated: true, completion: nil)
        let downloadLink = self.downloadPath
        
        //downloading book
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
                
                    self.saveToRealm(title: self.bTitle, author: self.bAuthor, imageURL: self.bookCoverURL, level: self.bLevel, summary: self.bDescription, filepath: "\(destinationURL)")
                }
            
        }
    }
    
    
    @IBAction func dismissView(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func saveToRealm(title:String, author:String, imageURL:String, level:String,
                     summary:String, filepath:String){
        let bookModel = BookModel()
        bookModel.title = title
        bookModel.author = author
        bookModel.image = imageURL
        bookModel.level = level
        bookModel.summary = summary
        bookModel.filename = filepath
        
        
        let realm = try! Realm()
        
        try! realm.write(){
            print("writing====>>")
            realm.add(bookModel)
        }
        
        let bookModelRetrieve = realm.objects(BookModel.self)
        print(bookModelRetrieve[0].filename)
    
    }
    
}
