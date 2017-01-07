//
//  LoginViewController.swift
//  SomaIOS
//
//  Created by ali ziwa on 9/17/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import AlertKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var student_pin: UITextField!
    @IBOutlet weak var student_number: UITextField!
    @IBOutlet weak var loginButt: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    let loader = ActivityViewController(message: "logging in...")
    
    
    override func viewWillAppear(_ animated: Bool) {
        let isLoggedIn:Bool = UserDefaults.standard.bool(forKey: Constants.constants().loggedIn)
        print(isLoggedIn)
        if isLoggedIn {
            self.goToMainPage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButt.layer.cornerRadius = 5
        self.backgroundView.layer.cornerRadius = 5

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @IBAction func loginButton(_ sender: AnyObject) {
        //dismiss current view
        self.dismiss(animated: true, completion: nil)
        
        //check if student name and password are available
        if (student_number.text != nil && student_pin.text != nil && !(student_number.text?.isEmpty)! && !(student_pin.text?.isEmpty)!){
            
            loginUser(student_number.text!, student_pin: student_pin.text!)
            
        }else{
            self.showActionSheet("Error", message: "Please fill in all fields")
        }
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //login
    //make call to server
    func loginUser(_ student_number:String,student_pin:String) {
        
        //show loader
        self.present(loader, animated: true, completion: nil)
        
        Alamofire.request(Constants.urls().loginURL,method:.post, parameters: ["student_number":student_number,
            "student_pin":student_pin]).responseJSON {
                response in
                //hide loader
                self.dismiss(animated: true, completion: nil)
                
                switch response.result{
                    
                case .success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        print(json)
                        if let status = json["status"].bool{
                            if status {
                                
                                //save preferences
                                UserDefaults.standard.setValue(json["result"][0]["token"].string, forKey: Constants.constants().userToken)
                                UserDefaults.standard.set(true, forKey: Constants.constants().loggedIn)
                                UserDefaults.standard.synchronize()
                                
                                //go to home page
                                self.goToMainPage()
                            }else{
                                self.showActionSheet("Failed to login", message: "User doesn't exist!")
                            }
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func goToMainPage(){
        self.performSegue(withIdentifier: "home", sender: self)
    }
   
}
