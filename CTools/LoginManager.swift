//
//  LoginManager.swift
//  CTools
//
//  Created by Ameya Khare on 4/12/15.
//  Copyright (c) 2015 ameyakhare. All rights reserved.
//

import Foundation

class LoginManager {
    static let cosignKey = "LoginCosignKey"
    static let cToolsCosignKey = "LoginCToolsCosignKey"
    
    static func storeKeys () {
        var def = NSUserDefaults.standardUserDefaults()
        
        var cosign = getCookieValue("https://weblogin.umich.edu", name: "cosign")
        var cosignCtools = getCookieValue("https://ctools.umich.edu", name: "cosign-ctools")
        
        def.setObject(cosign, forKey: cosignKey)
        def.setObject(cosignCtools, forKey: cToolsCosignKey)
        def.synchronize()
    }
    
    static func getCookieValue (domain: NSString, name: NSString) -> NSString? {
        
        var cookieJar = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        var url = NSURL(string: domain as String)
        var cookies = cookieJar.cookiesForURL(url!)
        
        for cookie in cookies as! [NSHTTPCookie] {
            if cookie.name == name {return cookie.value;}
        }
        
        return nil
    }
    
    static func storeCookies (#cosignValue: NSString, cosignCtoolsValue: NSString) {
        var cookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        
        // make cookies
        var cookie = NSHTTPCookie(properties: [NSHTTPCookiePath:"/",
            NSHTTPCookieDomain:"weblogin.umich.edu",NSHTTPCookieName:"cosign",
            NSHTTPCookieValue:cosignValue,NSHTTPCookieSecure:true])
        
        cookieStorage.setCookie(cookie!)
        
        cookie = NSHTTPCookie(properties: [NSHTTPCookiePath:"/",
            NSHTTPCookieDomain:"ctools.umich.edu",NSHTTPCookieName:"cosign-ctools",
            NSHTTPCookieValue:cosignCtoolsValue,NSHTTPCookieSecure:true])
        
        cookieStorage.setCookie(cookie!)
    }
    
}
