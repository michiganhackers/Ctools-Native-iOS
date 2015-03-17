//
//  ExampleViewController.swift
//  CTools
//
//  Created by Ameya Khare on 3/14/15.
//  Copyright (c) 2015 ameyakhare. All rights reserved.
//

import UIKit

class ExampleViewController: UITableViewController {
    var name:String?
    
    override func viewDidLoad() {
        if var hi = self.navigationController? {
            NSLog("kden")
            hi.title = "kden"
        }
    }
}