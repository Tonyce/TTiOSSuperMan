//
//  Colors.swift
//  superman
//
//  Created by D_ttang on 15/7/18.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    static let colorArr: [[String: AnyObject]] =  [
        ["color": UIColor.MKColor.LightBlue, "name": "默认颜色", "colorKey": "Default"],
        ["color": UIColor.MKColor.Red, "name": "番茄红", "colorKey": "Red"],
        ["color": UIColor.MKColor.DeepOrange, "name": "橘红", "colorKey": "DeepOrange"],
        ["color": UIColor.MKColor.Amber, "name": "香蕉黄", "colorKey": "Amber"],
        ["color": UIColor.MKColor.Grey, "name": "石墨黑", "colorKey": "Grey"],
        ["color": UIColor.MKColor.Indigo, "name": "蓝莓色", "colorKey": "Indigo"],
        ["color": UIColor.MKColor.Teal, "name": "罗勒绿", "colorKey": "Teal"],
        ["color": UIColor.MKColor.LightBlue, "name": "孔雀蓝", "colorKey": "LightBlue"],
        ["color": UIColor.MKColor.LightGreen, "name": "鼠尾草绿", "colorKey": "LightGreen"],
        ["color": UIColor.MKColor.Orange, "name": "红褐色", "colorKey": "Orange"],
        ["color": UIColor.MKColor.Purple, "name": "葡萄紫", "colorKey": "Purple"]
    ]
    
    static let colorsDic: [String: [String: AnyObject]] =  [
        "default": ["color": UIColor.MKColor.LightBlue, "name": "默认颜色"],
        "red": ["color": UIColor.MKColor.Red, "name": "番茄红"],
        "deepOrange": ["color": UIColor.MKColor.DeepOrange, "name": "橘红"],
        "amber":["color": UIColor.MKColor.Amber, "name": "香蕉黄", "colorKey": "Amber"],
        "grey":["color": UIColor.MKColor.Grey, "name": "石墨黑", "colorKey": "Grey"],
        "indigo": ["color": UIColor.MKColor.Indigo, "name": "蓝莓色", "colorKey": "Indigo"],
        "teal": ["color": UIColor.MKColor.Teal, "name": "罗勒绿", "colorKey": "Teal"],
        "lightBlue": ["color": UIColor.MKColor.LightBlue, "name": "孔雀蓝", "colorKey": "LightBlue"],
        "lightGreen": ["color": UIColor.MKColor.LightGreen, "name": "鼠尾草绿", "colorKey": "LightGreen"],
        "orange": ["color": UIColor.MKColor.Orange, "name": "红褐色", "colorKey": "Orange"],
        "purple": ["color": UIColor.MKColor.Purple, "name": "葡萄紫", "colorKey": "Purple"]
    ]
}