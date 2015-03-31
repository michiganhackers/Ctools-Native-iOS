//
//  SignInManager.swift
//  CTools
//
//  Created by Ameya Khare on 3/21/15.
//  Copyright (c) 2015 ameyakhare. All rights reserved.
//

import UIKit

class SignInManager {
    let COSIGN_KEY = "UMichSignIn"
    let CTOOLS_KEY = "CToolsSignIn"
    
    init () {
        //var def = NSUserDefaults.standardUserDefaults()
        attemptRestoreCosign()
    }
    
    func attemptRestoreCosign () {
        var def = NSUserDefaults.standardUserDefaults()
        var storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        
        var cosign = def.stringForKey(COSIGN_KEY)
        var ctoolsCosign = def.stringForKey(CTOOLS_KEY)
        
        if (cosign != nil && ctoolsCosign != nil) {
            NSLog("You blow dick");
            return;
        }
        
        /*var props = [NSHTTPCookieDomain:"weblogin.umich.edu",
            NSHTTPCookieName:"cosign",
            NSHTTPCookieValue:cosign,
            NSHTTPCookiePath:"/",
            NSHTTPCookieSecure:true,]
        
        var cookie = NSHTTPCookie(properties: props!)
        
        storage.setCookie(cookie!)
        
        props = [NSHTTPCookieDomain:"ctools.umich.edu",
            NSHTTPCookieName:"cosign-ctools",
            NSHTTPCookieValue:ctoolsCosign,
            NSHTTPCookiePath:"/",
            NSHTTPCookieSecure:true,]
        
        cookie = NSHTTPCookie(properties: props)!
        
        storage.setCookie(cookie!)*/
    }
}
