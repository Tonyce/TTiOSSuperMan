//
//  SystemConfig.swift
//  superman
//
//  Created by D_ttang on 15/7/18.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation

import UIKit

let defaultColorEntry = ["name":"孔雀蓝", "color": UIColor.MKColor.LightBlue]

class SystemConfig: NSObject {
    
    var systemColorEntry: [String: AnyObject]?
    
    class var sharedInstance: SystemConfig {
        struct Singleton {
            static let instance = SystemConfig()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        
        if systemColorEntry == nil {
            systemColorEntry = defaultColorEntry
        }
    }
}