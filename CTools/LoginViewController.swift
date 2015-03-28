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
    
    let cosignKey = "LoginCosignKey"
    let cToolsCosignKey = "LoginCToolsCosignKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "https://ctools.umich.edu/sakai-login-tool/container")
        NSLog("%@", url!)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
        //var cookieJar = NSHTTPCookieStorage.sharedHTTPCookieStorage()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var def = NSUserDefaults.standardUserDefaults()
        var cookieJar = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        
        var cosign = def.stringForKey(cosignKey)
        var cosignCtools = def.stringForKey(cToolsCosignKey)
        
        if (cosign == nil || cosignCtools == nil) {
            NSLog("store first time bitch!")
            storeKeys()
            return
        }
        
        NSLog("we found the shit")
        // see whether request works as well
        
        makeRequest(cosignBlah: cosign!, cosignCtoolsBlah: cosignCtools!);
    }
    
    func makeRequest (#cosignBlah: NSString, cosignCtoolsBlah: NSString) {
        var cookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        let url = NSURL(string: "https://ctools.umich.edu/direct/site.json")
        let request = NSURLRequest(URL: url!)
        
        // make cookie
        var cookie = NSHTTPCookie(properties: [NSHTTPCookiePath:"/",
            NSHTTPCookieDomain:"weblogin.umich.edu",NSHTTPCookieName:"cosign",
            NSHTTPCookieValue:cosignBlah,NSHTTPCookieSecure:true])
        
        cookieStorage.setCookie(cookie!)
        request.setValue(cookie!, forKey: "cosign")
        
        cookie = NSHTTPCookie(properties: [NSHTTPCookiePath:"/",
            NSHTTPCookieDomain:"ctools.umich.edu",NSHTTPCookieName:"cosign-ctools",
            NSHTTPCookieValue:cosignCtoolsBlah,NSHTTPCookieSecure:true])
        
        cookieStorage.setCookie(cookie!)
        request.setValue(cookie!, forKey: "cosign-ctools")
        
        // throw that shit at the server mofo
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
    }
    
    func storeKeys () {
        NSLog("storing now")
        var def = NSUserDefaults.standardUserDefaults()
        
        // check whether they even exist
        
        var cosign = getCookieValue("https://weblogin.umich.edu", name: "cosign")
        var cosignCtools = getCookieValue("https://ctools.umich.edu", name: "cosign-ctools")
        
        if (cosign == nil || cosignCtools == nil) {NSLog("user did not log in"); return}
        
        def.setObject(cosign, forKey: cosignKey)
        def.setObject(cosignCtools, forKey: cToolsCosignKey)
        def.synchronize()
    }
    
    func getCookieValue (domain: NSString, name: NSString) -> NSString? {
        
        var cookieJar = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        var url = NSURL(string: domain)
        var cookies = cookieJar.cookiesForURL(url!)
        
        for cookie in cookies as [NSHTTPCookie] {
            if cookie.name == name {return cookie.name;}
        }
        
        return nil
    }
}
