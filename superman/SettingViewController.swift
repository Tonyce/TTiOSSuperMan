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
    var topViewColor: UIColor = UIColor.MKColor.Blue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        closeBtn.setTitle(GoogleIcon.ebd0, forState: UIControlState.Normal)
        closeBtn.tintColor = UIColor.whiteColor()
        closeBtn.layer.cornerRadius = CGRectGetHeight(closeBtn.frame) / 2
        
//        keys = [String](model.keys).sort(<)
//        print(keys)
        
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
        
    }
    
//    override func viewWillAppear(animated: Bool) {
//        self.navigationController!.navigationBar.setBackgroundImage(nil , forBarMetrics: UIBarMetrics.Default)
//        self.navigationController!.navigationBar.shadowImage = nil
//        
//        navigationController?.navigationBar.barStyle = UIBarStyle.Black
//        navigationController?.navigationBar.barTintColor = topViewColor
//        
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Done, target: self, action: nil)
//        
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindSet(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? SelfCenterViewController,
            selfConfig = sourceViewController.selfConfig {
                self.selfConfig = selfConfig
        }
    }
    
    @IBAction func unwindSetColor(sender: UIStoryboardSegue) {
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "dismissSetting" {
            let mainView = segue.destinationViewController as! ViewController
            mainView.selfConfig = self.selfConfig
        }else if segue.identifier == "colorSetSegue"{
            let setColorView = segue.destinationViewController as! SelectColorViewController

                setColorView.delegate = self

            setColorView.selectColor = UIColor.MKColor.Red
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
//        let key = keys[section]
        
//        switch section {
//        case 0:
//            keyArray = model["me"]
//        case 1:
//            keyArray = model["subject"]
//        default:
//            keyArray = model[key as String]
//        }
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
            let systemColorCell = self.tableView.dequeueReusableCellWithIdentifier("colorSetCell")! as UITableViewCell
            systemColorCell.textLabel?.text = model[indexPath.section][indexPath.row]
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
    func colorPicker(picker: SelectColorViewController, didPickColor color: UIColor) {
        navigationController?.navigationBar.barTintColor = color
        navigationController?.popViewControllerAnimated(true)
    }
}
