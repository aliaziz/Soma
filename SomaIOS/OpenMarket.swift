//
//  OpenMarket.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/14/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit

class OpenMarket: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webURL = URL(string: "http://google.com")
        webView.loadRequest(NSURLRequest(url: webURL!) as URLRequest)
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
