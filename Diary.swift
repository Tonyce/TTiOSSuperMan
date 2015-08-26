//
//  Diary.swift
//  superman
//
//  Created by D_ttang on 15/7/29.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation
import CoreData

@objc(Diary)
class Diary: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    class func saveToCloud(diary: Diary, callback: (success: Bool?) -> Void) {
        let url: String = "http://\(host)/api/diary/save"
        
        let diaryBody:Dictionary<String, AnyObject> = [
            "id": diary.objectID.URIRepresentation().absoluteString,
            "colorEntryIndex": diary.colorEntryIndex as! Int,
            "content": diary.content! as String,
            "time": diary.time! as String,
        ]
        
        MyHTTPHandler.post(url, params: diaryBody) {
            
            data, response, err in
            
            let jsonParsed: AnyObject!
            var success: Bool?
            if err != nil {
                callback(success: success)
                return
            }
            do {
                jsonParsed = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
            }catch _ {
                print("err")
                callback(success: success)
                return
            }
            
            let jsonResult = JSONValue.fromObject(jsonParsed)!
            success = jsonResult["success"]?.bool
            callback(success: success)
        }
    }
    
    class func saveDiarysToCloud(diarys: [Diary], callback: (success: Bool?) -> Void) {
        let url: String = "http://\(host)/api/diary/save"
        
        var diaryArrsBody: [[String: AnyObject]] = []
//        let diaryArrsBody = [String: AnyObject]()
//        let diaryBody:Dictionary<String, AnyObject> = [
//            "id": diary.objectID.URIRepresentation().absoluteString,
//            "colorEntryIndex": diary.colorEntryIndex as! Int,
//            "content": diary.content! as String,
//            "time": diary.time! as String,
//        ]
        
        diaryArrsBody.append(["a":"a"])
        
        MyHTTPHandler.post(url, paramsArr: diaryArrsBody) {
            
            data, response, err in
            
            let jsonParsed: AnyObject!
            var success: Bool?
            if err != nil {
                callback(success: success)
                return
            }
            do {
                jsonParsed = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
            }catch _ {
                print("err")
                callback(success: success)
                return
            }
            
            let jsonResult = JSONValue.fromObject(jsonParsed)!
            success = jsonResult["success"]?.bool
            callback(success: success)
        }
    }
}


//            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("Body: \(strData)")

//        guard let content = diary.content else {return}
//        guard let time = diary.time else {return}
//        guard let colorEntryIndex = diary.colorEntryIndex else {return}