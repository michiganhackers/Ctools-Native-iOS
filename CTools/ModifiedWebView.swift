//
//  ModifiedWebView.swift
//  CTools
//
//  Created by Ameya Khare on 3/21/15.
//  Copyright (c) 2015 ameyakhare. All rights reserved.
//

import UIKit

class ModifiedWebView: UIWebView {
    
    override init () {
        NSLog("tried to load the view init")
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        NSLog("tried to load the view required")
        super.init(coder:aDecoder)
        loadPrelimView()
    }
    
    func loadPrelimView () {
        NSLog("tried to load the view")
        self.loadRequest(NSURLRequest(URL:NSURL(fileURLWithPath:"google.com")!))
    }
}
