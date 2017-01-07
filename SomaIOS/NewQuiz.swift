//
//  NewQuiz.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/13/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewQuiz: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var subjectsList = [String]()
    var subjectTeacher = [String]()
    var subjectLevel = [String]()
    var subjectID = [Int]()
    let token = "".token
    let loader = ActivityViewController(message: "fetching...")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.fetchQuizSubjects()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = self.subjectsList[indexPath.row]
        
        return cell
    }
    
    
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchQuizSubjects(){
        
        present(loader, animated: true, completion: nil)
        
        let level = "1"
        Alamofire.request("\(Constants.urls().homeURL)/studentExams/\(level)?token=\(token)")
            .responseJSON{
        
                response in
                
                switch response.result {
                case .success:
                    let json = JSON(response.result.value)
                
                    if let status = json["status"].bool{
                        if status {
                            
                            if let results = json["results"].array{
                            
                                for i in 0..<results.count {
                                    
                                    if let subject = results[i]["subject"].string{
                                        
                                        self.subjectsList.append(subject)
                                    
                                    }
                                    
                                    if let subTeacher = results[i]["teacher"].string {
                                        
                                        self.subjectTeacher.append(subTeacher)
                                    }
                                    
                                    if let subLevel = results[i]["level"].string{
                                        
                                        self.subjectLevel.append(subLevel)
                                    }
                                    
                                    if let subID = results[i]["id"].int {
                                        self.subjectID.append(subID)
                                    }
                                    
                                }//end of for loop
                            }
                            
                        }
                        
                        self.tableView.reloadData()
                    }
                    
                    //dismiss loader
                    self.delayActionSheet(time: 1.0, function: "dismissLoader")
                    
                case .failure(let error):
                    print(error)
                }
        
        }
        
    }
    
    func delayActionSheet(time:Double, function: String){
        
        switch function {
        
        case "actionSheet":
            break;
        case "dismissLoader":
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                    self.dismiss(animated: true, completion: nil)
            }
            break;
        default:
            break;
        }
        
    }
    

}
