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
    
    var loginStatus: [String:Int]?
    
    var model = [
        ["me"],
        
        ["color"],
        
        [
            ["img": GoogleIcon.e70c,"word":"赞一下", "href":"http://baidu.com", "colorIndex": 0 ],
            ["img":GoogleIcon.ec29 , "word":"建议及意见", "href":"http://youku.com", "colorIndex": 1],
            ["img":GoogleIcon.e985 , "word":"作者痕迹", "href":"http://taobao.com", "colorIndex": 0]
        ],
        
        [[ "login":1] ]
    ]
    
    var selfConfig: SelfConfig?
//    var topViewColor: UIColor = UIColor.MKColor.LightBlue
    var colorEntry: [String:AnyObject]!
    
    var willLoadUrl: String?
    
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
        if let sourceViewController = sender.sourceViewController as? SelfCenterViewController,
            selfConfig = sourceViewController.selfConfig {
//                self.selfConfig = selfConfig
                SelfConfig.sharedInstance.image = selfConfig.image
                SelfConfig.sharedInstance.word  = selfConfig.word
                SelfConfig.sharedInstance.isDefault = false
                
                SelfConfig.sharedInstance.saveSelfConfigs(SelfConfig.sharedInstance)
                self.tableView.reloadData()
        }
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
            
        }else if segue.identifier == "selfSetSegue"{
            let selfCenterView = segue.destinationViewController as! SelfCenterViewController
            selfCenterView.selfConfig = self.selfConfig
            
        }else if segue.identifier == "openWebSegue" {
            let tmpCell = self.tableView.cellForRowAtIndexPath(self.tableView.indexPathForSelectedRow!) as! AuthorArticleTableViewCell
            willLoadUrl = tmpCell.entry["href"] as? String
            let webView = segue.destinationViewController as! WebViewController
            webView.willLoadUrl = willLoadUrl
            
        }else if segue.identifier == "loginLogoutSegue" {
            let registerView = segue.destinationViewController as! LoginViewController
            registerView.delegate = self
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == "loginLogoutSegue" && loginStatus!["login"] == 1{
            
            let alertController = UIAlertController(
                title: nil,
                message: "正在退出",
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
            
            let action = UIAlertAction(title: "Done", style: UIAlertActionStyle.Cancel,
                handler: {(paramAction:UIAlertAction!) in
                
                self.model[self.model.count-1][0] = ["login": 0]
                
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
            let systemColorCell = self.tableView.dequeueReusableCellWithIdentifier("colorSetCell") as! SettingViewColorCell
            systemColorCell.colorEntry = SystemConfig.sharedInstance.systemColorEntry
            systemColorCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return systemColorCell
            
        case 2:
            let m = model[2][indexPath.row] as? [String: AnyObject]
            let authorArticleCell = self.tableView.dequeueReusableCellWithIdentifier("authorArticleCell") as! AuthorArticleTableViewCell
            authorArticleCell.entry = m
            authorArticleCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return authorArticleCell
        
        case model.count-1:
            let m = model[model.count-1][0] as? [String: Int]
            let loginLogoutCell = self.tableView.dequeueReusableCellWithIdentifier("loginLogoutCell") as! LoginLogoutCell
            
            loginStatus = m
            
            loginLogoutCell.entry = m

            return loginLogoutCell
            
        default:
            cell?.textLabel?.text = ""
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell!
        }

        /*
        if indexPath.section == 0 {
            let meCell = self.tableView.dequeueReusableCellWithIdentifier("meCell") as! meTableViewCell
            meCell.selfConfig = self.selfConfig
            return meCell
            
        }else if indexPath.section == 1 {
            let systemColorCell = self.tableView.dequeueReusableCellWithIdentifier("colorSetCell") as! SettingViewColorCell
            systemColorCell.colorEntry = SystemConfig.sharedInstance.systemColorEntry
            systemColorCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return systemColorCell
            
        } else if indexPath.section == 2 {
            let m = model[2][indexPath.row] as? [String: AnyObject]
            let authorArticleCell = self.tableView.dequeueReusableCellWithIdentifier("authorArticleCell") as! AuthorArticleTableViewCell
            authorArticleCell.entry = m
            authorArticleCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return authorArticleCell
        }else {
            cell?.textLabel?.text = model[indexPath.section][indexPath.row] as? String
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell!
        }
        */
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
    
    func colorPicker(picker: SelectColorViewController, didPickColorEntry colorEntry: [String: AnyObject], colorIndex index: Int) {
        
        SystemConfig.sharedInstance.systemColorEntry = colorEntry
        
        SystemConfig.sharedInstance.saveSystemConfig("systemColor", value: index)
        
        tableView.reloadData()
        navigationController?.popViewControllerAnimated(true)
    }
}

extension SettingViewController: LoginViewControllerDelegate {
    func writeLoginStatus(loginStatus: [String : Int]) {
        self.model[model.count-1][0] = loginStatus
        self.tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
}
