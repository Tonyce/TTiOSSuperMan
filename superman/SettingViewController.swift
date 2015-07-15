//
//  SettingViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/10.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    
//    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var model = [
        "other":["c", "b"],
        "z": ["z"],
        "tt": ["tt"],
        "me": ["me"]
    ]
    var keys = ["me"]
    var meValue = ["me"]
    
    var selfConfig: SelfConfig?
    var meCell: meTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.barTintColor = UIColor.redColor()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Done, target: self, action: nil)

        // Do any additional setup after loading the view.
        
        closeBtn.setTitle(GoogleIcon.ebd0, forState: UIControlState.Normal)
        closeBtn.tintColor = UIColor.whiteColor()
        closeBtn.layer.cornerRadius = CGRectGetHeight(closeBtn.frame) / 2
        
        keys = [String](model.keys).sort(<)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindSet(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? SelfCenterViewController,
            selfConfig = sourceViewController.selfConfig {
                self.selfConfig = selfConfig
                meCell.wordTextView.text = self.selfConfig?.word!
                meCell.selfImage.image = self.selfConfig?.image
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "dismissSetting" {
            let mainView = segue.destinationViewController as! ViewController
            mainView.selfConfig = self.selfConfig
        }else {
            let selfCenterView = segue.destinationViewController as! SelfCenterViewController
            selfCenterView.selfConfig = self.selfConfig
        }
        

    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return model.keys.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        var keyArray = model[key as String]
        return (keyArray?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let key = keys[indexPath.section]
        var keyArray:Array = model[key as String]!
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        if indexPath.section == 0 {
            meCell = self.tableView.dequeueReusableCellWithIdentifier("meCell") as! meTableViewCell
            meCell.selfImage.image = selfConfig?.image
            meCell.wordTextView.text = selfConfig?.word
//            selfConfig = SelfConfig(image: meCell.selfImage.image!, word: meCell.wordTextView.text)
            // print(meCell.wordTextView.text)
            meCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return meCell
        }else {
            cell?.textLabel?.text = keyArray[indexPath.row]
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }else {
            return 50
        }
        
    }
}


/*
navigationController?.navigationBar.barStyle = UIBarStyle.Black
navigationController?.navigationBar.barTintColor = UIColor.redColor()
// navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
//        let font = UIFont(name: "SourceSansPro-Regular", size: 22)
//        if let font = font {
//            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.whiteColor()]
//        }

// navigationController?.navigationItem.setHidesBackButton(true, animated: false)
//        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
//        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 20)!], forState: UIControlState.Normal)
navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Done, target: self, action: nil)
//        navigationController?.navigationItem.hidesBackButton = true
// Do any additional setup after loading the view.
*/