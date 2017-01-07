//
//  FirstViewController.swift
//  SomaIOS
//
//  Created by ali ziwa on 9/17/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import AlertKit

class HomeViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imagesArray = [UIImage(named: "book"),UIImage(named: "audio"),UIImage(named: "vides"),UIImage(named: "calendar"),UIImage(named: "quiz"),UIImage(named: "classroom"),
                       UIImage(named: "timetable"),UIImage(named: "weather"),UIImage(named: "infomakt")]
    let textArray = ["Books","Audio","Videos","Calendar","Quiz","Classroom","Timetable","Weather", "Info Market"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "bookshelf-bg-320.png")!)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCellCollectionViewCell
        
        cell.productImage.image = imagesArray[(indexPath as NSIndexPath).row]
        cell.productLabel.text = textArray[(indexPath as NSIndexPath).row]
        //cell.productImage.layer.shadowColor = UIColor.black.cgColor
        //cell.productImage.layer.shadowOffset = CGSize(width: 1, height: 1);
        //cell.productImage.layer.shadowOpacity = 0.5;
        //cell.productImage.layer.shadowRadius = 3.0;
        //cell.productImage.clipsToBounds = false;
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).row {
        case 0:
            self.performSegue(withIdentifier: "booksView", sender: self)
            break;
        case 1:
            self.performSegue(withIdentifier: "audioView", sender: self)
            break;
        case 2:
            self.performSegue(withIdentifier: "videoView", sender: self)
            break;
        case 3:
            self.performSegue(withIdentifier: "calendaView", sender: self)
            break;
        case 4:
            showOptions()
            break;
        case 5:
            self.performSegue(withIdentifier: "classroomView", sender: self)
            break;
        case 6:
            self.performSegue(withIdentifier: "timetableView", sender: self)
            break;
        case 7:
            self.performSegue(withIdentifier: "weatherView", sender: self)
            break;
        case 8:
            self.performSegue(withIdentifier: "infoMarketView", sender: self)
            break;
        default:
            break;
        }
    }

    func showOptions(){
        
        let viewQuizHistory = UIAlertAction(title: "View Quiz History", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //call the mtn view
            self.performSegue(withIdentifier: "quizHistoryView", sender: self)
        })
        let newQuiz = UIAlertAction(title: "Try new quiz", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "newQuizView", sender: self)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        self.showActionSheet("Quiz Options", message: "Choose one option", alertActions: [viewQuizHistory,newQuiz, cancelAction])
        
    }
    
   }

