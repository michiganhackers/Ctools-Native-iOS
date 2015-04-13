//
//  CourseViewController.swift
//  CTools
//
//  Created by Ameya Khare on 4/12/15.
//  Copyright (c) 2015 ameyakhare. All rights reserved.
//

import UIKit

class CourseViewController: UITableViewController, UITableViewDelegate {
    
    var courseDescriptions: [AnyObject] = []
    
    override func viewDidLoad() {
        let url = NSURL(string: "https://ctools.umich.edu/direct/mycourses/all-courses.json")
        let request = NSMutableURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            var err: NSError?
            var theJSON = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as! NSMutableDictionary
            for course in theJSON["mycourses_collection"] as! NSArray {
                self.courseDescriptions.append(course);
            }
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseDescriptions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as! UITableViewCell
        let course: AnyObject = courseDescriptions[indexPath.row]
        
        let subject: AnyObject? = course["subject"]!
        let nmbr: AnyObject? = course["catalog_nbr"]!
        let comp: AnyObject? = course["component"]!
        cell.textLabel!.text = "\(subject!) \(nmbr!) (\(comp!))"
        
        return cell
    }
    
    @IBAction func cancel (sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
