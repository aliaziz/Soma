//
//  BookMain.swift
//  SomaIOS
//
//  Created by ali ziwa on 9/20/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import Alamofire
import AlertKit
import Kingfisher
import SwiftyJSON
//import RealmSwift

class BookMainView: UIViewController {

    @IBOutlet weak var onlineBooksContainer: UIView!
    @IBOutlet weak var downloadedBooksContainer: UIView!
    @IBOutlet weak var favouritesBooksContainer: UIView!
    @IBOutlet weak var selectionController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.onlineBooksContainer.alpha = 1
        self.downloadedBooksContainer.alpha = 0
        self.favouritesBooksContainer.alpha = 0
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ChangeViewsPerSelection(_ sender: AnyObject) {
        
        if selectionController.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.onlineBooksContainer.alpha = 1
                self.downloadedBooksContainer.alpha = 0
                self.favouritesBooksContainer.alpha = 0
            })
            
        }else if selectionController.selectedSegmentIndex == 1 {
             UIView.animate(withDuration: 0.5, animations: {
                self.onlineBooksContainer.alpha = 0
                self.downloadedBooksContainer.alpha = 1
                self.favouritesBooksContainer.alpha = 0
             })
        
        }  else if selectionController.selectedSegmentIndex == 2 {
             UIView.animate(withDuration: 0.5, animations: {
                self.onlineBooksContainer.alpha = 0
                self.downloadedBooksContainer.alpha = 0
                self.favouritesBooksContainer.alpha = 1
             })
        
        }
    }

       
    }

extension String {
    
    var token : String{return UserDefaults.standard.value(forKey: Constants.constants().userToken) as! String}
}
