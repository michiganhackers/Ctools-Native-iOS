//
//  ClassItemManager.swift
//  CTools
//
//  Created by Ameya Khare on 3/14/15.
//  Copyright (c) 2015 ameyakhare. All rights reserved.
//

import Foundation

class CourseManager {
    var courseList = [Course]()
    
    init () {
        var blah = Course(name:"Slavic 150")
        var blah2 = Course(name:"BishCOM 250")
        
        courseList.append(blah)
        courseList.append(blah2)
    }
    
    // this is where you will do all the initialization stuff and what not
    // based on class passed in and what not
}