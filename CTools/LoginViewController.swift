//
//  LoginViewController.swift
//  CTools
//
//  Created by Ameya Khare on 3/21/15.
//  Copyright (c) 2015 ameyakhare. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://stackoverflow.com")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
}
