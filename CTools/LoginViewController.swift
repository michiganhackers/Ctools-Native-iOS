//
//  LoginViewController.swift
//  CTools
//
//  Created by Ameya Khare on 3/21/15.
//  Copyright (c) 2015 ameyakhare. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet var webView: UIWebView!
    
    let cosignKey = "LoginCosignKey"
    let cToolsCosignKey = "LoginCToolsCosignKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "https://ctools.umich.edu/sakai-login-tool/container")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        webView.delegate = self
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let targetURL = NSURL(string: "https://ctools.umich.edu/portal")
        
        if (request.URL! == targetURL) {
            var def = NSUserDefaults.standardUserDefaults()
            var cookieJar = NSHTTPCookieStorage.sharedHTTPCookieStorage()
            
            var cosign = def.stringForKey(cosignKey)
            var cosignCtools = def.stringForKey(cToolsCosignKey)
            
            LoginManager.storeKeys()
            
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        return true
    }
    
    @IBAction func cancel(sender: AnyObject?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func makeRequest (#cosignBlah: NSString, cosignCtoolsBlah: NSString) {
        var cookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        let url = NSURL(string: "https://ctools.umich.edu/direct/mycourses/all-courses.json")
        let request = NSMutableURLRequest(URL: url!)
        
        // make cookie
        var cookie = NSHTTPCookie(properties: [NSHTTPCookiePath:"/",
            NSHTTPCookieDomain:"weblogin.umich.edu",NSHTTPCookieName:"cosign",
            NSHTTPCookieValue:cosignBlah,NSHTTPCookieSecure:true])
        
        cookieStorage.setCookie(cookie!)
        
        cookie = NSHTTPCookie(properties: [NSHTTPCookiePath:"/",
            NSHTTPCookieDomain:"ctools.umich.edu",NSHTTPCookieName:"cosign-ctools",
            NSHTTPCookieValue:cosignCtoolsBlah,NSHTTPCookieSecure:true])
        
        cookieStorage.setCookie(cookie!)
        
        // throw that shit at the server mofo
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            var err: NSError?
            var theJSON = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as! NSMutableDictionary
            println(theJSON["entityPrefix"] as! String)
            for course in theJSON["mycourses_collection"] as! NSArray {
                let subject = course["subject"]!
                let nmbr = course["catalog_nbr"]!
                println("\(subject!) \(nmbr!)")
            }
        }
        // some buggy stuff might happen
    }
}
