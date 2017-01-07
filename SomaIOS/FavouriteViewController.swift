//
//  FavouriteViewController.swift
//  SomaIOS
//
//  Created by ali ziwa on 9/21/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bookshelf-bg-320.png")!)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "booksCell", for: indexPath) as! FavouritesCollectionViewCell
        
        return cell
    }
}
