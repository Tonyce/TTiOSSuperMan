//
//  ViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/8.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var friendBtn: UIButton!
    @IBOutlet weak var selfImage: UIImageView!
    @IBOutlet weak var selfWord: UITextView!
    @IBOutlet weak var diaryTable: UITableView!
    @IBOutlet weak var addDiaryBtn: MyAddButton!
    @IBOutlet weak var topView: UIView!
    
    var managedContext: NSManagedObjectContext!
    
    var topViewInitFrame: CGRect!
    var topViewColor: UIColor = UIColor.MKColor.LightBlue
    
    var selectIndexPath: NSIndexPath?
    
    var colorEntry: [String: AnyObject]!
    
    let openDiaryTransition = OpenDiaryAnimation()
    let addDiaryAnimation = AddDiaryAnimation()
    let openSettingAnimation = OpenSettingAnimation()
    
    var addDiaryInitFrame: CGRect!
    var diarys = [Diary]()
    var diarysArr = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        topViewInitFrame = topView.frame
        
        diarysArr += []

        insertSampleData()
        
        let request = NSFetchRequest(entityName: "Diary")
        request.sortDescriptors = [NSSortDescriptor(key: "time", ascending: false)]
        
        do {
            diarys = try managedContext.executeFetchRequest(request) as! [Diary]
        }catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
        
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
        // animateTable()
        initSettingBtn()

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        animateTable()
        
        self.addDiaryBtn.center.x = self.addDiaryInitFrame.origin.x + 300
        
        let savedColorEntry:[String: AnyObject] = SystemConfig.sharedInstance.systemColorEntry!
        
        let selfConfig = SelfConfig.sharedInstance
        
        
        
        colorEntry = savedColorEntry
        
        topView.backgroundColor = colorEntry["color"] as? UIColor

        statusView.backgroundColor = colorEntry["color"] as? UIColor
        
        selfImage.image = selfConfig.image
        selfWord.text = selfConfig.word
        
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
        
        selfImage.layer.cornerRadius = CGRectGetHeight(selfImage.frame) / 2
        selfImage.layer.masksToBounds = true
        selfWord.backgroundColor = UIColor.clearColor()
        selfWord.text = "路漫漫其修远兮\n吾将上下而求索"
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
        // if let sourceViewController = sender.sourceViewController as? SettingViewController,
        //    selfConfig = sourceViewController.selfConfig {
        //        self.selfConfig = selfConfig
        //        selfImage.image = self.selfConfig?.image
        //        selfWord.text = self.selfConfig?.word
        // }
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
        
        let diaryEntry = diarys[indexPath.row] as Diary
      
        cell.diaryEntry = diaryEntry
        
        let cellBackView = UIView(frame: cell.frame)
        cell.selectedBackgroundView = cellBackView
        cell.selectedBackgroundView?.backgroundColor = UIColor.clearColor()

        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == .Delete {
                
                let diaryToRemove = diarys[indexPath.row]
                // print(diaryToRemove.objectID)
                
                managedContext.deleteObject(diaryToRemove)
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save \(error), \(error.userInfo)")
                }
                
                diarys.removeAtIndex(indexPath.row)
                //  Delete the row from the data source
                
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
            } else if editingStyle == .Insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }    
        
    }
    
    func animateTable() {
        diaryTable.reloadData()
        
        let cells = diaryTable.visibleCells
//        let tableHeight: CGFloat = diaryTable.bounds.size.height
         let tableWidth: CGFloat = diaryTable.bounds.size.width
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
//            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
            cell.transform = CGAffineTransformMakeTranslation(tableWidth, 0)
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

        var topViewTransform:CATransform3D  = CATransform3DIdentity
        if offset <= 0 { // DOWN
            // print("down \(offset)")
            
            let headerScaleFactor:CGFloat = -(offset) / self.topView.bounds.size.height
            let statusScaleFactor:CGFloat = -(offset) / self.statusView.bounds.size.height
            let headerSizevariation:CGFloat  = ((self.topView.bounds.size.height * (1.0 + headerScaleFactor)) - self.topView.bounds.size.height)/2.0
            topViewTransform = CATransform3DTranslate(topViewTransform, 0, headerSizevariation, 0)
            let statusViewTransform = CATransform3DScale(CATransform3DIdentity, 1.0 + headerScaleFactor, 1.0 + statusScaleFactor, 0)
           

            self.topView.layer.transform = topViewTransform
            self.addDiaryBtn.layer.transform = topViewTransform
            self.statusView.layer.transform = statusViewTransform
            clearTopViewShadow()
        } else { // UP
            
            // print("up \(offset)")
            
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
    
    @IBAction func unwindToDiaryList(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.sourceViewController as? DiaryViewController,
//            diaryEntry = sourceViewController.diaryEntry {
//                if let selectedIndexPath = self.diaryTable.indexPathForSelectedRow {
//                    // Update an existing meal.
//                    diarys[selectedIndexPath.row] = diaryEntry
//                    do {
//                        try managedContext.save()
//                    } catch let error as NSError {
//                        print("Could not save \(error), \(error.userInfo)")
//                    }
//                    self.diaryTable.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
//                }
//        }
        
        if let sourceViewController = sender.sourceViewController as? AddDiaryViewController ,
            diaryEntryContainer = sourceViewController.diaryEntryContainer {
        
                let entity =  NSEntityDescription.entityForName("Diary", inManagedObjectContext: managedContext)
                
                let diary = Diary(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                // print(diary.objectID)
                diary.time = diaryEntryContainer.time
                diary.content = diaryEntryContainer.content
                diary.colorEntryIndex = diaryEntryContainer.colorEntryIndex

                let newIndexPath = NSIndexPath(forRow: 0, inSection: 0)
                
                diarys.insert(diary, atIndex: 0)
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not save \(error), \(error.userInfo)")
                }
                
                self.diaryTable.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Top)
                
                if SelfConfig.sharedInstance.allowBak == true {
                    
                    Diary.saveToCloud(diary){
                        success in
                        
                        diary.baked = success

                        func save() {
                            do {
                                try self.managedContext.save()
                            } catch let error as NSError {
                                print("Could not save \(error), \(error.userInfo)")
                            }
                            
                            let diaryIndex = self.diarys.indexOf(diary)
                            let indexPath = NSIndexPath(forRow: diaryIndex!, inSection: 0)
                            // print(diaryIndex)
                            self.diaryTable.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                        }
                        dispatch_async(dispatch_get_main_queue()) {
                            _ in
                            save()
                        }
                    }
                }

                /*
                Diary.saveDiarysToCloud([]){
                    success in
                    diary.baked = success
                    
                    func inner() {
                        do {
                            try self.managedContext.save()
                        } catch let error as NSError {
                            print("Could not save \(error), \(error.userInfo)")
                        }
                        
                        let diaryIndex = self.diarys.indexOf(diary)
                        let indexPath = NSIndexPath(forRow: diaryIndex!, inSection: 0)
                        // print(diaryIndex)
                        self.diaryTable.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                        _ in
                        inner()
                    }
                }
                */
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "ShowAndEditDiary" {

            if let indexPath = self.diaryTable.indexPathForSelectedRow {
//                 let diaryView = segue.destinationViewController as! DiaryViewController
                let testDiaryView = segue.destinationViewController as! TestDiaryViewController
//
                let diaryEntry = self.diarys[indexPath.row]
//
                let rectOfCellInTableView = self.diaryTable.rectForRowAtIndexPath(indexPath)
                let tmpOriginFrame = self.diaryTable.convertRect(rectOfCellInTableView, toView: diaryTable.superview)
                openDiaryTransition.tmpOriginFrame = tmpOriginFrame
//
                testDiaryView.diaryEntry = diaryEntry
                segue.destinationViewController.transitioningDelegate = openDiaryTransition
//                diaryView.diaryEntry = diaryEntry as Diary
//                diaryView.transitioningDelegate = openDiaryTransition

            }
        }
        
        if segue.identifier == "addDiary" {
            let addDiaryView = segue.destinationViewController as! AddDiaryViewController

            openSettingAnimation.fromFrame = self.addDiaryBtn.frame
            openSettingAnimation.fromFrameCenter = self.addDiaryBtn.center
            addDiaryView.transitioningDelegate = addDiaryAnimation
        }
        
        if segue.identifier == "settingSegue" {
            let settingView = segue.destinationViewController as! SettingViewController
            openSettingAnimation.fromFrame = self.settingBtn.frame
            openSettingAnimation.fromFrameCenter = self.settingBtn.center
//            settingView.selfConfig = self.selfConfig
            settingView.colorEntry = self.colorEntry
//            settingView.transitioningDelegate = openSettingAnimation
        }
        
        if segue.identifier == "imageSettingSegue" {
//            let nav = segue.destinationViewController as! UINavigationController

//            let settingView = nav.topViewController as! SettingViewController
            openSettingAnimation.fromFrame = self.selfImage.frame
            openSettingAnimation.fromFrameCenter = self.selfImage.center
//            settingView.selfConfig = self.selfConfig
//            settingView.colorEntry = self.colorEntry
//            nav.transitioningDelegate = openSettingAnimation
        }
        
    }
}

extension ViewController {
    
    func insertSampleData(){
        let fetchRequest = NSFetchRequest(entityName: "Diary")
        // fetchRequest.predicate = NSPredicate(format: "time != nil")
        let count = managedContext.countForFetchRequest(fetchRequest, error: nil)
        if count > 0 {
            return
        }
        
        for dict : AnyObject in diarysArr {
            // print(dict)
            let entity =  NSEntityDescription.entityForName("Diary", inManagedObjectContext: managedContext)
            
            let diary = Diary(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            let btDict = dict as! NSDictionary
            
            diary.time = btDict["time"] as? String
            diary.content = btDict["content"] as? String
            diary.colorEntryIndex = btDict["colorEntryIndex"] as? NSNumber
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
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


//let instanceURL = diaryToRemove.objectID.URIRepresentation()
//print(instanceURL)
//print(instanceURL.absoluteString)
//let instanceURLStr = instanceURL.absoluteString
//                let classURL = instanceURL().URLByDeletingLastPathComponent
//
//                let classString = classURL!.absoluteString
//                let instanceId = instanceURL().lastPathComponent
//
//                print(classString)
//                print(instanceId)


//                let reconstructedClassURL = NSURL(fileURLWithPath:classString)
//                reconstructedClassURL.URLByAppendingPathComponent(pathComponent: String)
//                let reconstructedInstanceURL = reconstructedClassURL.URLByAppendingPathComponent(instanceId!)

//                print(reconstructedInstanceURL)

//let ganInstanceURL = NSURL(string: instanceURLStr)
//
//let objectID = managedContext.persistentStoreCoordinator?.managedObjectIDForURIRepresentation(ganInstanceURL!)
//
//print(objectID!)
//let reconstructedInstance = managedContext.objectWithID(objectID!)

//                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//                dispatch_async(dispatch_get_global_queue(priority, 0)) {
//                    _ in
////
//self.saveToCloud(diary){
//    success in
//    diary.baked = success
//    
//    func inner() {
//        do {
//            try self.managedContext.save()
//        } catch let error as NSError {
//            print("Could not save \(error), \(error.userInfo)")
//        }
//        
//        let diaryIndex = self.diarys.indexOf(diary)
//        let indexPath = NSIndexPath(forRow: diaryIndex!, inSection: 0)
//        // print(diaryIndex)
//        self.diaryTable.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
//    }
//    dispatch_async(dispatch_get_main_queue()) {
//        _ in
//        inner()
//    }
//}

// initSelfConfig
// selfConfig = SelfConfig(image: UIImage(named: "defaultImage")!, word: "路漫漫其修远兮\n吾将上下而求索")


// initTable
//        let entry1 = DiaryEntry(time: "11.02", content:"name: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", photo: photo1, rating: 4", colorEntryIndex: 2)
//        let entry2 = DiaryEntry(time: "12.04", content: "UIImage(named:meal2.jpglet meal2 = Meal(name: \"Chicken and Potatoes\", photo: photo2, rating: 5", colorEntryIndex: 5)
//        let entry3 = DiaryEntry(time: "11.04", content: "String(name: \"Pasta with Meatballs\", photo: photo3, rating: 3", colorEntryIndex: 3)
//        let entry1 = ["time": "11.02", "content":"name: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", ame: \"Caprese Salad\", photo: photo1, rating: 4", "colorEntryIndex": 2]
//        let entry2 = ["time": "12.04", "content": "UIImage(named:meal2.jpglet meal2 = Meal(name: \"Chicken and Potatoes\", photo: photo2, rating: 5", "colorEntryIndex": 5]
//        let entry3 = ["time": "11.04", "content": "String(name: \"Pasta with Meatballs\", photo: photo3, rating: 3", "colorEntryIndex": 3]
