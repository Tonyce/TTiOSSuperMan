//
//  DiaryEntry.swift
//  superman
//
//  Created by D_ttang on 15/7/8.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation
import UIKit

class DiaryEntry: NSObject, NSCoding {
    
    var time: String?
    // var unixTime: Int?
    var content: String?
    var colorEntryIndex : Int?
    
    init(time: String, content: String, colorEntryIndex: Int) {
        self.time = time
        self.content = content
        self.colorEntryIndex = colorEntryIndex
        
        super.init()
    }
    
    // MARK: Types
    struct PropertyKey {
        static let timeKey = "time"
        static let contentKey = "content"
        static let colorKey = "color"
    }
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory,
        inDomains: NSSearchPathDomainMask.UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("diarys")
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(time, forKey: PropertyKey.timeKey)
        aCoder.encodeObject(content, forKey: PropertyKey.contentKey)
        aCoder.encodeObject(colorEntryIndex, forKey: PropertyKey.colorKey)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let time = aDecoder.decodeObjectForKey(PropertyKey.timeKey) as! String
        let content = aDecoder.decodeObjectForKey(PropertyKey.contentKey) as! String
        let colorEntryIndex = aDecoder.decodeObjectForKey(PropertyKey.colorKey) as! Int
        // Must call designated initializer.
        self.init(time: time, content: content, colorEntryIndex: colorEntryIndex)
    }
    
    
}