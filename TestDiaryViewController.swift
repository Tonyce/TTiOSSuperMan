//
//  TestDiaryViewController.swift
//  superman
//
//  Created by D_ttang on 15/8/18.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class TestDiaryViewController: UIViewController {

    var diaryEntry: Diary?
    
    @IBOutlet weak var closeBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // print(diaryEntry)

        print(diaryEntry!.objectID)
        closeBtn.setTitle(GoogleIcon.e811, forState: UIControlState.Normal)
        closeBtn.tintColor = UIColor.whiteColor()
        closeBtn.layer.cornerRadius = CGRectGetHeight(closeBtn.frame) / 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
