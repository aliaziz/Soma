//
//  AudioMainView.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/11/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit

class AudioMainView: UIViewController {

    @IBOutlet weak var onlineAudiosView: UIView!
    @IBOutlet weak var localAudiosView: UIView!
    @IBOutlet weak var segementControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.onlineAudiosView.alpha = 1
        self.localAudiosView.alpha = 0

    }

    @IBAction func changeViewPerSelection(_ sender: AnyObject) {
        if segementControl.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.onlineAudiosView.alpha = 1
                self.localAudiosView.alpha = 0
            })
            
        }else if segementControl.selectedSegmentIndex == 1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.onlineAudiosView.alpha = 0
                self.localAudiosView.alpha = 1
            })
        }
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
