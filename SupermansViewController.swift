//
//  SupermansViewController.swift
//  superman
//
//  Created by D_ttang on 15/8/13.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit


func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}


class SupermansViewController: UITableViewController {
    
    var refreshView: RefreshView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        title = "Supermans"
        tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, view.bounds.width, 20))
        tableView.tableHeaderView?.backgroundColor = UIColor.whiteColor()
        
        let refreshRect = CGRect(x: 0.0, y: -60, width: view.frame.size.width, height: 60)
        refreshView = RefreshView(frame: refreshRect, scrollView: self.tableView)
//        refreshView.backgroundColor = UIColor.grayColor()
        refreshView.delegate = self
        view.addSubview(refreshView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("supermanCell", forIndexPath: indexPath) as! SupermanCell
        
        // Configure the cell...
        cell.supermanNameLabel?.text = String(indexPath.row)
        
        return cell
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Supers", style: .Plain, target: nil, action: nil)
    }
    

}

extension SupermansViewController: RefreshViewDelegate {
    // MARK: Refresh control methods
    func refreshViewDidRefresh(refreshView: RefreshView) {
        delay(seconds: 4) {
            refreshView.endRefreshing()
        }
    }
    
    // MARK: Scroll view methods
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        refreshView.scrollViewDidScroll(scrollView)
    }
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        refreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
}
