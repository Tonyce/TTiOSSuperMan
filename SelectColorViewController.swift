//
//  SelectPhotoWayViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/16.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

protocol SelectColorViewControllerDelegate: class {
//    func colorPicker(picker: SelectColorViewController, didPickColorEntry colorEntry: [String: AnyObject])
    func colorPicker(picker: SelectColorViewController, didPickColorEntry colorEntry: [String: AnyObject], colorIndex index: Int)
}

class SelectColorViewController: UIViewController {
    
    weak var delegate: SelectColorViewControllerDelegate?
    
//    var systemColorEntry:[String: AnyObject] = SystemConfig.sharedInstance.systemColorEntry!
    
    var nowColorEntry: [String: AnyObject]?
    
    let colorArr = Colors.colorArr
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SelectColorViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorArr.count
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let colorEntry = colorArr[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("colorCell", forIndexPath: indexPath) as! ColorViewCell
        
        cell.colorEntry = colorEntry
        
        if colorEntry as NSObject == nowColorEntry {
            cell.colorCircleLabel.text = GoogleIcon.eacd
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let delegate = delegate {
            
            let colorEntry = colorArr[indexPath.row]
            
//            delegate.colorPicker(self, didPickColorEntry: colorEntry)
            delegate.colorPicker(self, didPickColorEntry: colorEntry, colorIndex: indexPath.row)
        }
    }
}


//        ["color": UIColor.MKColor.Red, "name": ""],
//        ["color": UIColor.MKColor.Pink, "name": ""],
//        ["color": UIColor.MKColor.Yellow, "name": "黄"],
//        ["color": UIColor.MKColor.BlueGrey, "name": "石墨黑"],
//        ["color": UIColor.MKColor.Brown, "name": "棕色"],
//        ["color": UIColor.MKColor.Green, "name": "绿"],
//        ["color": UIColor.MKColor.Cyan, "name": "孔雀蓝"],
//        ["color": UIColor.MKColor.DeepPurple, "name": "鼠尾草绿"],
//        ["color": UIColor.MKColor.Lime, "name": "孔雀蓝"],