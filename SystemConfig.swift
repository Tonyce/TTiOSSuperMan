//
//  SystemConfig.swift
//  superman
//
//  Created by D_ttang on 15/7/18.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation
import UIKit

class SystemConfig: NSObject {
    
    var isFirstIn: Bool?
    
    var systemConfigData: NSMutableDictionary?
    
    var systemColorEntry: [String: AnyObject]?
    let colorArr = Colors.colorArr
    let defaultColorEntry = Colors.colorArr[0]
    
    var settingEntrys: [[String: AnyObject]]?
    let defaultSettingEntrys = [ ["img":GoogleIcon.ec29 , "word":"建议及意见", "href":"http://haosou.com", "colorIndex": 0] ]
//    let defaultSettingEntrys = [ ["img": "\u{ec29}" , "word":"建议及意见", "href":"http://youku.com", "colorIndex": 0] ]
    
//    var userName: String?
//    var lastLoginTime: Int?
    
    class var sharedInstance: SystemConfig {
        struct Singleton {
            static let instance = SystemConfig()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        
        systemConfigData = readSystemConfig()
        
        if let systemConfigData = systemConfigData {
            if let colorEntryLocation = systemConfigData["systemColor"] as? Int {
                systemColorEntry = colorArr[colorEntryLocation]
            }
            
            if let settingEntrysData = systemConfigData["settingEntrys"] as? [[String: AnyObject]] {
                settingEntrys = settingEntrysData
            }
            
            if let isFirstInData = systemConfigData["isFirstIn"] as? Bool {
                isFirstIn = isFirstInData
            }

        }
        
        if systemColorEntry == nil {
            systemColorEntry = defaultColorEntry
        }
        
        if settingEntrys == nil {
            settingEntrys = defaultSettingEntrys as? [[String: AnyObject]]
        }
    }
    
    func saveSystemConfig(key: String, value: AnyObject){
        let filename: NSString = self.filePath("systemConfig.plist")
        var data: NSMutableDictionary
        
        if let fileData = NSMutableDictionary(contentsOfFile: filename as String) {
            data = fileData
        }else {
            data = NSMutableDictionary()
        }
        
        data.setObject(value, forKey: key)
        data.writeToFile(filename as String, atomically: true)

    }
    
    func readSystemConfig() -> NSMutableDictionary?{
        let filename:NSString = self.filePath("systemConfig.plist")
        if NSFileManager.defaultManager().fileExistsAtPath(filename as String) {
            let data:NSMutableDictionary = NSMutableDictionary(contentsOfFile: filename as String)!
            return data
        }
        return nil
    }
    
    func filePath(filename: NSString) -> NSString {
        let mypaths:NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let mydocpath:NSString = mypaths.objectAtIndex(0) as! NSString
        let filepath = mydocpath.stringByAppendingPathComponent(filename as String)
        return filepath
    }
}

//            for var colorEntry in SelectColorViewController.
//            var savedSystemColorEntry: [String : AnyObject] = (systemConfigData["systemColor"] as? [String: AnyObject])!
//            savedSystemColorEntry["color"] = NSKeyedUnarchiver.unarchiveObjectWithData(savedSystemColorEntry["color"] as! NSData)
//            systemColorEntry = savedSystemColorEntry