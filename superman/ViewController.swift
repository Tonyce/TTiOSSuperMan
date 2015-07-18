//
//  ViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/8.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var friendBtn: UIButton!
    @IBOutlet weak var selfImage: UIImageView!
    @IBOutlet weak var selfWord: UITextView!
    @IBOutlet weak var diaryTable: UITableView!
    @IBOutlet weak var addDiaryBtn: MyAddButton!
    @IBOutlet weak var topView: UIView!
    
    var topViewInitFrame: CGRect!
    var topViewColor: UIColor = UIColor.MKColor.LightBlue
    
    var selectIndexPath: NSIndexPath?
    
    var selfConfig: SelfConfig?
    var colorEntry: [String: AnyObject]!
    
    let openDiaryTransition = OpenDiaryAnimation()
    let addDiaryAnimation = AddDiaryAnimation()
    let openSettingAnimation = OpenSettingAnimation()
    
    var addDiaryInitFrame: CGRect!
    var diarys = [DiaryEntry]()
    override func viewDidLoad() {
        super.viewDidLoad()

        topViewInitFrame = topView.frame
        // initSelfConfig
        // selfConfig = SelfConfig(image: UIImage(named: "defaultImage")!, word: "路漫漫其修远兮\n吾将上下而求索")
        selfConfig = SelfConfig.sharedInstance
        
        // initTable
        let entry1 = DiaryEntry(time: "11.02", content:"name: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", photo: photo1, rating: 4")
        let entry2 = DiaryEntry(time: "12.04", content: "UIImage(named:meal2.jpglet meal2 = Meal(name: \"Chicken and Potatoes\", photo: photo2, rating: 5")
        let entry3 = DiaryEntry(time: "11.04", content: "String(name: \"Pasta with Meatballs\", photo: photo3, rating: 3")
        diarys += [entry1, entry2, entry3, entry1, entry2, entry3,entry1, entry2, entry3,entry1, entry2, entry3]

        diaryTable.delegate = self
        diaryTable.dataSource = self
        
        diaryTable.tableHeaderView = UIView(frame: CGRectMake(self.topView.frame.origin.x, self.topView.frame.origin.x, self.topView.frame.size.width, self.topView.frame.size.height + 50))
        diaryTable.tableHeaderView?.backgroundColor = UIColor.whiteColor()
        
        let littleLabel = UILabel(frame: CGRectMake(15, self.topView.frame.size.height + 15 , 100, 20))
        littleLabel.text = "嘻嘻哈哈~"
        littleLabel.textColor = UIColor.grayColor()
        littleLabel.font = UIFont.systemFontOfSize(12)
        
        diaryTable.tableHeaderView?.addSubview(littleLabel)

        statusView.backgroundColor = topViewColor
        // shadowTopView()
        initAddBtn()
        animateTable()
        initSettingBtn()

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.addDiaryBtn.center.x = self.addDiaryInitFrame.origin.x + 300
        
        let savedColorEntry:[String: AnyObject] = SystemConfig.sharedInstance.systemColorEntry!
        
        colorEntry = savedColorEntry
        
        topView.backgroundColor = colorEntry["color"] as? UIColor

        statusView.backgroundColor = colorEntry["color"] as? UIColor
        
        UIView.animateWithDuration(0.5, animations: {
                self.addDiaryBtn.frame = self.addDiaryInitFrame
            }, completion: nil)
        if let selectedIndexPath = self.diaryTable.indexPathForSelectedRow {
            self.diaryTable.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }
    
    func initAddBtn(){
        addDiaryBtn.layer.cornerRadius = CGRectGetHeight(self.addDiaryBtn.frame) / 2
        //addDiaryBtn.layer.masksToBounds = true
        addDiaryBtn.layer.shadowOpacity = 0.5
        addDiaryBtn.layer.shadowOffset  = CGSize(width: 0, height: 1.5)
        addDiaryBtn.layer.shadowColor   = UIColor.blackColor().CGColor
        addDiaryBtn.layer.shadowRadius  = 10.0
        addDiaryInitFrame = addDiaryBtn.frame
        addDiaryBtn.center.x = addDiaryBtn.frame.origin.x + 200
    }
    
    func initSettingBtn(){
        settingBtn.setTitle(GoogleIcon.e6c5, forState: UIControlState.Normal)
        settingBtn.tintColor = UIColor.whiteColor()
        settingBtn.layer.cornerRadius = CGRectGetHeight(settingBtn.frame) / 2
        
        friendBtn.setTitle(GoogleIcon.e7cb, forState: UIControlState.Normal)
        friendBtn.tintColor = UIColor.whiteColor()
        friendBtn.layer.cornerRadius = CGRectGetHeight(settingBtn.frame) / 2
        
        selfImage.layer.cornerRadius = CGRectGetHeight(selfImage.frame) / 2
        selfImage.layer.masksToBounds = true
        selfWord.backgroundColor = UIColor.clearColor()
        selfWord.text = "路漫漫其修远兮\n吾将上下而求索"
        
        selfImage.image = selfConfig?.image
        selfWord.text = selfConfig?.word
    }
    
    func shadowTopView(){
        topView.layer.shadowOpacity = 0.7
        topView.layer.shadowOffset  = CGSize(width: 1, height: 1)
        topView.layer.shadowColor   = UIColor.grayColor().CGColor
        //topView.layer.shadowRadius  = 10.0
    }
    
    func clearTopViewShadow(){
        topView.layer.shadowOpacity = 0
        topView.layer.shadowOffset  = CGSizeZero
        topView.layer.shadowColor   = UIColor.clearColor().CGColor
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func unwindSetSelfConfig(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? SettingViewController,
            selfConfig = sourceViewController.selfConfig {
                self.selfConfig = selfConfig
                selfImage.image = self.selfConfig?.image
                selfWord.text = self.selfConfig?.word
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diarys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("diaryCell", forIndexPath: indexPath) as! DiaryTableViewCell
        
        let diaryEntry = diarys[indexPath.row]
        cell.labelField.text = diaryEntry.time
        cell.circleIdentifyLabel.font = UIFont(name: GoogleIconName, size: 12.0)
        cell.circleIdentifyLabel.textColor = UIColor.MKColor.LightBlue
        cell.circleIdentifyLabel.text = GoogleIcon.eacd
        
        let cellBackView = UIView(frame: cell.frame)
        cell.selectedBackgroundView = cellBackView
        cell.selectedBackgroundView?.backgroundColor = UIColor.clearColor()
        // cell.backgroundColor = UIColor.clearColor()
        // cell.selectionStyle = UITableViewCellSelectionStyle.None
        // cell.contentText.text = cellEntry.content
        return cell
    }
    
    func animateTable() {
        diaryTable.reloadData()
        
        let cells = diaryTable.visibleCells
        let tableHeight: CGFloat = diaryTable.bounds.size.height
        // let tableWidth: CGFloat = diaryTable.bounds.size.width
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
            //cell.transform = CGAffineTransformMakeTranslation(tableWidth, 0)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(0.5, delay: 0.025 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                    cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        self.animationForScroll(offset)

    }
   
    func animationForScroll(offset:CGFloat){
        //print("\(offset)")
        var topViewTransform:CATransform3D  = CATransform3DIdentity
        if offset <= 0 { // DOWN
            let headerScaleFactor:CGFloat = -(offset) / self.topView.bounds.size.height
            let statusScaleFactor:CGFloat = -(offset) / self.statusView.bounds.size.height
            let headerSizevariation:CGFloat  = ((self.topView.bounds.size.height * (1.0 + headerScaleFactor)) - self.topView.bounds.size.height)/2.0
            topViewTransform = CATransform3DTranslate(topViewTransform, 0, headerSizevariation, 0)
            let statusViewTransform = CATransform3DScale(CATransform3DIdentity, 1.0 + headerScaleFactor, 1.0 + statusScaleFactor, 0)
           

            self.topView.layer.transform = topViewTransform
            self.addDiaryBtn.layer.transform = topViewTransform
            self.statusView.layer.transform = statusViewTransform

        } else { // UP
            
            if offset > 10 {
                shadowTopView()
            }else {
                clearTopViewShadow()
            }
            
            let headerScaleFactor:CGFloat = -(offset) / self.topView.bounds.size.height
            let headerSizevariation:CGFloat  = ((self.topView.bounds.size.height * (1.0 + headerScaleFactor)) - self.topView.bounds.size.height)/2.0
            topViewTransform = CATransform3DTranslate(topViewTransform, 0, headerSizevariation, 0)

            self.topView.layer.transform = topViewTransform
            self.addDiaryBtn.layer.transform = topViewTransform
        }

    }
}

extension ViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "ShowAndEditDiary" {

            if let indexPath = self.diaryTable.indexPathForSelectedRow {
                // selectIndexPath = indexPath
                // let item = self.tableItems[indexPath.row]
                
                let rectOfCellInTableView = self.diaryTable.rectForRowAtIndexPath(indexPath)
                let tmpOriginFrame = self.diaryTable.convertRect(rectOfCellInTableView, toView: diaryTable.superview)
                openDiaryTransition.tmpOriginFrame = tmpOriginFrame
                segue.destinationViewController.transitioningDelegate = openDiaryTransition
                // (segue.destinationViewController as! InfoViewController).item = item
            }
        }
        
        if segue.identifier == "addDiary" {
            let diaryView = segue.destinationViewController as! DiaryViewController
            diaryView.editBtn?.alpha = 0.0
            diaryView.doneBtn?.alpha = 1.0
            diaryView.isFromAdd = true

            diaryView.isDiaryEditing = false
            openSettingAnimation.fromFrame = self.addDiaryBtn.frame
            openSettingAnimation.fromFrameCenter = self.addDiaryBtn.center
            diaryView.transitioningDelegate = addDiaryAnimation
        }
        
        if segue.identifier == "settingSegue" {
            let settingView = segue.destinationViewController as! SettingViewController
            openSettingAnimation.fromFrame = self.settingBtn.frame
            openSettingAnimation.fromFrameCenter = self.settingBtn.center
            settingView.selfConfig = self.selfConfig
            settingView.colorEntry = self.colorEntry
            settingView.transitioningDelegate = openSettingAnimation
        }
        
        if segue.identifier == "imageSettingSegue" {
            let nav = segue.destinationViewController as! UINavigationController

            let settingView = nav.topViewController as! SettingViewController
            openSettingAnimation.fromFrame = self.selfImage.frame
            openSettingAnimation.fromFrameCenter = self.selfImage.center
//            settingView.selfConfig = self.selfConfig
//            settingView.colorEntry = self.colorEntry
            nav.transitioningDelegate = openSettingAnimation
        }
        
    }
}

extension NSUserDefaults {
    
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = dataForKey(key) {
            color = NSKeyedUnarchiver.unarchiveObjectWithData(colorData) as? UIColor
        }
        return color
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedDataWithRootObject(color)
        }
        setObject(colorData, forKey: key)
    }
    
}
