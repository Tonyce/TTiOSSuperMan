//
//  SuperInfoViewController.swift
//  superman
//
//  Created by D_ttang on 15/8/14.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class SuperInfoViewController: UIViewController {

    @IBOutlet weak var barItem: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.navigationController?.title = "Info"
//        self.navigationController?.navigationItem.title = "Info"
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.title = "Info"
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
