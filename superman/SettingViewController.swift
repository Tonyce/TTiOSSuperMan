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
        ["me"],["color"], ["c", "b"], ["z"], ["tt"]
    ]
    
    var keys = ["me"]
    var meValue = ["me"]
    
    var selfConfig: SelfConfig?
//    var topViewColor: UIColor = UIColor.MKColor.LightBlue
    var colorEntry: [String:AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        closeBtn.setTitle(GoogleIcon.ebd0, forState: UIControlState.Normal)
        closeBtn.tintColor = UIColor.whiteColor()
        closeBtn.layer.cornerRadius = CGRectGetHeight(closeBtn.frame) / 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        colorEntry = SystemConfig.sharedInstance.systemColorEntry

        navigationController?.navigationBar.barTintColor = colorEntry["color"] as? UIColor

        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }
    
    @IBAction func unwindSet(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? SelfCenterViewController,
            selfConfig = sourceViewController.selfConfig {
                self.selfConfig = selfConfig
                self.tableView.reloadData()
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "dismissSetting" {
            let mainView = segue.destinationViewController as! ViewController
            mainView.selfConfig = self.selfConfig
            SystemConfig.sharedInstance.systemColorEntry = self.colorEntry
            
        }else if segue.identifier == "colorSetSegue"{
            let setColorView = segue.destinationViewController as! SelectColorViewController
            setColorView.delegate = self
            setColorView.selectColor = navigationController?.navigationBar.barTintColor
            
        }else{
            let selfCenterView = segue.destinationViewController as! SelfCenterViewController
            selfCenterView.selfConfig = self.selfConfig
        }
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var keyArray: Array = model[section] as Array
        return keyArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        if indexPath.section == 0 {
            let meCell = self.tableView.dequeueReusableCellWithIdentifier("meCell") as! meTableViewCell
            meCell.selfConfig = self.selfConfig
            return meCell
            
        }else if indexPath.section == 1 {
            let systemColorCell = self.tableView.dequeueReusableCellWithIdentifier("colorSetCell") as! SettingViewColorCell
            systemColorCell.colorEntry = colorEntry
//            systemColorCell.textLabel?.text = model[indexPath.section][indexPath.row]
            systemColorCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return systemColorCell
            
        }else {
            
            cell?.textLabel?.text = model[indexPath.section][indexPath.row]
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

extension SettingViewController: SelectColorViewControllerDelegate {
    func colorPicker(picker: SelectColorViewController, didPickColorEntry colorEntry: [String: AnyObject]) {
        
//        SystemConfig.sharedInstance.systemColorEntry = colorEntry
        
//        navigationController?.navigationBar.barTintColor = colorEntry["color"] as? UIColor
//        self.colorEntry = colorEntry
//        topViewColor = colorEntry["color"] as! UIColor
        self.tableView.reloadData()
        navigationController?.popViewControllerAnimated(true)
    }
}
