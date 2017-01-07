//
//  SecondViewController.swift
//  SomaIOS
//
//  Created by ali ziwa on 9/17/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: Constants.constants().loggedIn)
        UserDefaults.standard.synchronize()
        print(UserDefaults.standard.value(forKey: Constants.constants().userToken))
    }    
}

