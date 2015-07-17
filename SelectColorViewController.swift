//
//  SelectPhotoWayViewController.swift
//  superman
//
//  Created by D_ttang on 15/7/16.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

protocol SelectColorViewControllerDelegate: class {
    func colorPicker(picker: SelectColorViewController, didPickColor color: UIColor)
}

class SelectColorViewController: UIViewController {
    
    weak var delegate: SelectColorViewControllerDelegate?
    
    var selectColor: UIColor?
    
    let colorArr: [[String: AnyObject]] = [
        ["color": UIColor.MKColor.LightBlue, "name": "默认颜色"],
        ["color": UIColor.MKColor.Red, "name": "番茄红"],
        ["color": UIColor.MKColor.DeepOrange, "name": "橘红"],
        ["color": UIColor.MKColor.Amber, "name": "香蕉黄"],
        ["color": UIColor.MKColor.Grey, "name": "石墨黑"],
        ["color": UIColor.MKColor.Indigo, "name": "蓝莓色"],
        ["color": UIColor.MKColor.Teal, "name": "罗勒绿"],
        ["color": UIColor.MKColor.LightBlue, "name": "孔雀蓝"],
        ["color": UIColor.MKColor.LightGreen, "name": "鼠尾草绿"],
        ["color": UIColor.MKColor.Orange, "name": "红褐色"],
        ["color": UIColor.MKColor.Purple, "name": "葡萄紫"],
        
//        ["color": UIColor.MKColor.Red, "name": ""],
//        ["color": UIColor.MKColor.Pink, "name": ""],
//        
//        ["color": UIColor.MKColor.Yellow, "name": "黄"],
//        ["color": UIColor.MKColor.BlueGrey, "name": "石墨黑"],
//        ["color": UIColor.MKColor.Brown, "name": "棕色"],
//        ["color": UIColor.MKColor.Green, "name": "绿"],
//        ["color": UIColor.MKColor.Cyan, "name": "孔雀蓝"],
//        ["color": UIColor.MKColor.DeepPurple, "name": "鼠尾草绿"],
//        ["color": UIColor.MKColor.Lime, "name": "孔雀蓝"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        if let selectColor = selectColor {
            if selectColor == colorEntry["color"] as! UIColor {
                cell.selected = true
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let delegate = delegate {
            let color = colorArr[indexPath.row]["color"] as! UIColor
            delegate.colorPicker(self, didPickColor: color)
        }
    }
}
