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
    
    @IBOutlet weak var lastFooterLabel: UILabel!
    
    var loginStatus: [String:Bool]?
    
    var version = ""
    
    var model = [
        ["me"],
        
        ["color", "friends"],
        
        [["img":GoogleIcon.e985 , "word":"作者痕迹", "href":"http://baidu.com", "colorIndex": 0]],
        
        [
            // ["img": GoogleIcon.e70c,"word":"赞一下", "href":"https://itunes.apple.com/cn/app/liu-li-xue-yuan/id978249810?mt=8", "colorIndex": 0 ],
            ["img": "\u{ec29}" , "word":"建议及意见", "href":"http://haosou.com", "colorIndex": 0]
        ],
        

        
        [ [ "logined":false] ]
    ]
    
    var selfConfig: SelfConfig?

    var colorEntry: [String:AnyObject]!
    
    var willLoadUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        version = appVersion()
        lastFooterLabel.text = "version:" + APPVERSIOIN
        
        model[3] = SystemConfig.sharedInstance.settingEntrys!
        // SystemConfig.sharedInstance.settingEntrys = model[3] as? [[String: AnyObject]]
        // SystemConfig.sharedInstance.saveSystemConfig("settingEntrys", value: SystemConfig.sharedInstance.settingEntrys!)
        if let _ = SelfConfig.sharedInstance.userName {
            model[model.count - 1] = [["logined": true]]
        }
        
        // Do any additional setup after loading the view.
        closeBtn.setTitle(GoogleIcon.ebd0, forState: UIControlState.Normal)
        closeBtn.tintColor = UIColor.whiteColor()
        closeBtn.layer.cornerRadius = CGRectGetHeight(closeBtn.frame) / 2
        
        lastFooterLabel.shadowColor = UIColor(red: 0.8, green: 0.86, blue: 0.88, alpha: 1.0)
        tableView.registerClass(LastSectionFootView.self, forHeaderFooterViewReuseIdentifier: "lastSectionFootView")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        selfConfig = SelfConfig.sharedInstance
        colorEntry = SystemConfig.sharedInstance.systemColorEntry

        navigationController?.navigationBar.barTintColor = colorEntry["color"] as? UIColor
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
        
        self.tableView.reloadData()

    }
    
    @IBAction func unwindSet(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.sourceViewController as? SelfCenterViewController {
//            selfConfig = sourceViewController.selfConfig {
//                self.selfConfig = selfConfig
//                SelfConfig.sharedInstance.image = selfConfig.image
//                SelfConfig.sharedInstance.word  = selfConfig.word
                SelfConfig.sharedInstance.isDefault = false
                
                SelfConfig.sharedInstance.saveSelfConfigs(SelfConfig.sharedInstance)
                self.tableView.reloadData()
//        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "dismissSetting" {
            // let mainView = segue.destinationViewController as! ViewController
            // mainView.selfConfig = self.selfConfig
            SystemConfig.sharedInstance.systemColorEntry = self.colorEntry
            
        }else if segue.identifier == "colorSetSegue"{
            let setColorView = segue.destinationViewController as! SelectColorViewController
            setColorView.delegate = self
            setColorView.nowColorEntry = self.colorEntry
//            setColorView.selectColorEntry = SystemConfig.sharedInstance.systemColorEntry
            
//        }else if segue.identifier == "selfSetSegue"{
//            let selfCenterView = segue.destinationViewController as! SelfCenterViewController
//            selfCenterView.selfConfig = self.selfConfig
            
        }else if segue.identifier == "openWebSegue" {
            let tmpCell = self.tableView.cellForRowAtIndexPath(self.tableView.indexPathForSelectedRow!) as! AuthorArticleTableViewCell
            willLoadUrl = tmpCell.entry["href"] as? String
            let webView = segue.destinationViewController as! WebViewController
            webView.willLoadUrl = willLoadUrl
            
        }else if segue.identifier == "loginLogoutSegue" {
            let registerView = segue.destinationViewController as! LoginViewController
            registerView.delegate = self
        }
        if segue.identifier == "supermanSegue"{
//            self.navigationItem.backBarButtonItem?.title = ""
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        }else {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: self.title, style: .Plain, target: nil, action: nil)
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == "loginLogoutSegue" && loginStatus!["logined"] == true{
            
            let alertController = UIAlertController(
                title: nil,
                message: "退出?",
                preferredStyle: UIAlertControllerStyle.Alert)
            
//            alertController.addTextFieldWithConfigurationHandler( {(textField: UITextField!) in
//                textField.placeholder = "XXXXXXXXXX"
//                })
//            
//            let loading = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
//            
//            loading.center =  CGPointMake(130.5, 65.5)
//            loading.color = UIColor.blackColor()
//            loading.startAnimating()
            
            let action = UIAlertAction(title: "YES", style: UIAlertActionStyle.Cancel,
                handler: {(paramAction:UIAlertAction!) in
                
                self.model[self.model.count-1] = [["logined": false]]
                self.selfConfig?.userName = nil
                SelfConfig.sharedInstance.saveSelfConfigs(self.selfConfig!)
                    
                self.tableView.reloadData()
                
//                if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
//                    self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
//                }
            })
//            alertController.view.addSubview(loading)
            alertController.addAction(action)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return false
        }
        
        if identifier == "openWebSegue" {
            
            if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                    
                    let tmpCell = self.tableView.cellForRowAtIndexPath(selectedIndexPath) as! AuthorArticleTableViewCell
                    willLoadUrl = tmpCell.entry["href"] as? String
                    let word = tmpCell.entry["word"] as? String
                    
                    if word == "赞一下" {
                    
                        UIApplication.sharedApplication().openURL(NSURL(string: willLoadUrl!)!)
                        
                        self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
                        
                        return false
                    }

            }
        }
        
        return true
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
    
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == model.count-1 {
            let footView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("lastSectionFootView")
            return footView
        }else {
            return nil
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        switch indexPath.section {

        case 0:
            let meCell = self.tableView.dequeueReusableCellWithIdentifier("meCell") as! meTableViewCell
            meCell.selfConfig = self.selfConfig
            return meCell

        case 1:
            if indexPath.row == 0 {
                let systemColorCell = self.tableView.dequeueReusableCellWithIdentifier("colorSetCell") as! SettingViewColorCell
                systemColorCell.colorEntry = SystemConfig.sharedInstance.systemColorEntry
                systemColorCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                return systemColorCell
            }else {
                let friendsCell = self.tableView.dequeueReusableCellWithIdentifier("friendsCell") as! FriendsCell

                friendsCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                return friendsCell
            }
            
        case 2:
            let m = model[2][indexPath.row] as? [String: AnyObject]
            let authorArticleCell = self.tableView.dequeueReusableCellWithIdentifier("authorArticleCell") as! AuthorArticleTableViewCell
            authorArticleCell.entry = m
            authorArticleCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return authorArticleCell
            
        case 3:
            let m = model[3][indexPath.row] as? [String: AnyObject]
            let authorArticleCell = self.tableView.dequeueReusableCellWithIdentifier("authorArticleCell") as! AuthorArticleTableViewCell
            authorArticleCell.entry = m
            authorArticleCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return authorArticleCell
        
        case model.count-1:
            let m = model[model.count-1][0] as? [String: Bool]
            let loginLogoutCell = self.tableView.dequeueReusableCellWithIdentifier("loginLogoutCell") as! LoginLogoutCell
            
            loginStatus = m
            
            loginLogoutCell.entry = m

            return loginLogoutCell
            
        default:
            cell?.textLabel?.text = ""
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell!
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 90
        }else {
            return 45
        }
    }
}

extension SettingViewController: SelectColorViewControllerDelegate {
    
    func colorPicker(picker: SelectColorViewController, didPickColorEntry colorEntry: [String: AnyObject], colorIndex index: Int) {
        
        SystemConfig.sharedInstance.systemColorEntry = colorEntry
        
        SystemConfig.sharedInstance.saveSystemConfig("systemColor", value: index)
        
        tableView.reloadData()
        navigationController?.popViewControllerAnimated(true)
    }
}

extension SettingViewController: LoginViewControllerDelegate {
    func writeLoginStatus(loginStatus: [String : Bool], name: String) {
        self.model[model.count-1][0] = loginStatus
        selfConfig?.userName = name
        SelfConfig.sharedInstance.saveSelfConfigs(selfConfig!)
        self.tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
}
