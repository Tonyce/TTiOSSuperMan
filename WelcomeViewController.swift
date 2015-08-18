//
//  WelcomeViewController.swift
//  superman
//
//  Created by D_ttang on 15/8/11.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
import CoreData

class WelcomeViewController: UIViewController {

    var managedContext: NSManagedObjectContext!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var timer = NSTimer()
    var timeCount = 0
    var timerRuning = false
    
    var currenPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pageControl.currentPage = 0
        
        print(pageControl.numberOfPages)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("left:"))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("right:"))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc(left:)
    func leftCommand(r: UIGestureRecognizer!) {

        currenPage = currenPage < pageControl.numberOfPages-1 ? currenPage+1 : pageControl.numberOfPages-1
        
        print("left...\(currenPage)")
        pageControl.currentPage = currenPage
    }
    
    @objc(right:)
    func rightCommand(r: UIGestureRecognizer!) {

        currenPage = currenPage > 0 ? currenPage-1 : 0
                print("right...\(currenPage)")
        pageControl.currentPage = currenPage
    }
    
    override func viewWillAppear(animated: Bool) {
//        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("Counting"), userInfo: nil, repeats: true)
    }
    
    func Counting(){
        timeCount += 1
        if timeCount > 3 {
            timer.invalidate()
            print("-------")
            self.showMainView()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        timer.invalidate()
        SystemConfig.sharedInstance.isFirstIn = false
        SystemConfig.sharedInstance.saveSystemConfig("isFirstIn", value: false)
        
        let view = segue.destinationViewController as! ViewController
        view.managedContext = self.managedContext
    }
    
    func showMainView(){
        let mainViewController = storyboard?.instantiateViewControllerWithIdentifier("mainView") as! ViewController
        mainViewController.managedContext = self.managedContext
        presentViewController(mainViewController, animated: false, completion: nil)
    }
    

}
