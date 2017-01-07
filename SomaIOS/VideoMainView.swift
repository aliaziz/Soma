//
//  VideoMainView.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/12/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit

class VideoMainView: UIViewController {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var onlineContainter: UIView!
    @IBOutlet weak var localContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.onlineContainter.alpha = 1
        self.localContainer.alpha = 0
    }

    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func ChangeViewOnPress(_ sender: AnyObject) {
        if segmentControl.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.onlineContainter.alpha = 1
                self.localContainer.alpha = 0
            })
            
        }else if segmentControl.selectedSegmentIndex == 1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.onlineContainter.alpha = 0
                self.localContainer.alpha = 1
            })
        }
    }
}
