//
//  AddDiaryViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/24.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class AddDiaryViewController: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeBtn.setTitle(GoogleIcon.e811, forState: UIControlState.Normal)
        closeBtn.tintColor = UIColor.whiteColor()
        closeBtn.layer.cornerRadius = CGRectGetHeight(closeBtn.frame) / 2
        
        saveBtn.setTitle(GoogleIcon.e649, forState: UIControlState.Normal)
        saveBtn.tintColor = UIColor.whiteColor()
        saveBtn.layer.cornerRadius = CGRectGetHeight(saveBtn.frame) / 2

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
