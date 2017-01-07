//
//  Register.swift
//  SomaIOS
//
//  Created by ali ziwa on 9/17/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import Alamofire
import AlertKit
import SwiftyJSON

class Register: UIViewController {

    @IBOutlet weak var student_number: UITextField!
    @IBOutlet weak var student_name: UITextField!
    @IBOutlet weak var student_level: UITextField!
    @IBOutlet weak var student_pin: UITextField!
    @IBOutlet weak var registerButt: UIButton!
    
    let loader = ActivityViewController(message: "Registering...") 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerButt.layer.cornerRadius = 5
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Register.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @IBAction func CancelButton(_ sender: AnyObject) {
        
        self.goToLoginPage()
    }
    
    @IBAction func registerButton(_ sender: AnyObject) {
        if !(student_name.text?.isEmpty)! && !(student_pin.text?.isEmpty)! && !(student_level.text?.isEmpty)!
            && !(student_number.text?.isEmpty)!{
            
            registerUser(student_number.text!, student_pin: student_pin.text!, student_names: student_name.text!, student_level: student_level.text!)
        }else{
            self.showActionSheet("Error", message: "Please fill in all fields")
        }
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //register user on server
    func registerUser(_ student_number:String, student_pin:String, student_names:String, student_level:String){
        
        self.present(loader, animated: true, completion: nil)
        
        Alamofire.request(Constants.urls().registerURL,method:.post, parameters: ["student_number":student_number,
            "student_pin":student_pin, "student_names":student_names, "student_level":student_level]).responseJSON {
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
                                
                                //go to home page
                                self.goToLoginPage()
                            }else{
                                self.showActionSheet("Failed to register", message: "User already exist!")
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                }
        }

    }
    
    //go to login page after successful registratino
    func goToLoginPage(){
        self.dismiss(animated: true, completion: nil)
    }
}
