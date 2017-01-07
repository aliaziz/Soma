//
//  LocalBooks.swift
//  SomaIOS
//
//  Created by ali ziwa on 9/21/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import RealmSwift
import PDFReader

class LocalBooks: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource  {

    var books_array = [String]()
    var books_names = [String]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchBooksFromDB()
        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bookshelf-bg-320.png")!)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "booksCell", for: indexPath) as! LocalBooksCollectionViewCell
        cell.image.image = UIImage(named: "blank")
        cell.name.text = books_names[indexPath.row]
        cell.image.layer.shadowColor = UIColor.black.cgColor
        cell.image.layer.shadowOffset = CGSize(width: 1, height: 1);
        cell.image.layer.shadowOpacity = 0.5;
        cell.image.layer.shadowRadius = 3.0;
        cell.image.clipsToBounds = false;
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "bookDetails", sender: self)
        let indexPaths = self.collectionView!.indexPathsForSelectedItems!
        let indexPath = indexPaths[0] as IndexPath
        
        let pdfLink = self.books_array[indexPath.row]
        
        if let doc = document(getPDFNameFromPath(path: pdfLink.replacingOccurrences(of: "%20", with: " "))) {
            showDocument(doc, position: indexPath.row)
        } else {
            print("Document named \(pdfLink) not found in the file system")
        }
        

    }
    
    
    func getPDFNameFromPath(path: String)->String {
        let pdfLink = path
        
        let index2 = pdfLink.range(of: "/", options: .backwards)?.lowerBound
        
        let substring2 = pdfLink.substring(from: index2!)
        
        print(substring2)
        
        print("\(substring2) file path after removing pdf slashes")
        
        return substring2
    }
    
    func fetchBooksFromDB(){
        let localBooks = try! Realm().objects(BookModel.self)
        
        for i in 0..<localBooks.count {
            books_array.append(localBooks[i].filename as String)
            books_names.append(localBooks[i].title as String)
            print("\(localBooks[i].filename ) ==> local books")
        }
    }
    
    fileprivate func showDocument(_ document: PDFDocument, position:Int) {
        let image = UIImage(named: "")
        let controller = PDFViewController.createNew(with: document, title: books_names[position], actionButtonImage: image, actionStyle: .activitySheet)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    fileprivate func document(_ name: String) -> PDFDocument? {
        //Bundle.init(path: name)
        guard let documentURL = getDocumentsURL().appendingPathComponent(name)
            else { return nil }
        print(documentURL)
        //return PDFDocument(fileURL: URL(string: name)!)
        return PDFDocument(fileURL: documentURL)
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL as NSURL
    }
    
}
