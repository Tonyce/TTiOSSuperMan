//
//  SelfConfig.swift
//  superman
//
//  Created by D_ttang on 15/7/15.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation
import UIKit

class SelfConfig: NSObject {
    var image: UIImage?
    var word: String?
    var userName: String?
    
    var isDefault = true
    
    struct PropertyKey {
        static let imageKey = "image"
        static let userNameKey = "name"
        static let wordKey = "word"
    }
    
//    var instance:
    
    class var sharedInstance: SelfConfig {
        struct Singleton {
            static let instance = SelfConfig.initInstance()
        }
        return Singleton.instance
    }
    
    
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory,
        inDomains: NSSearchPathDomainMask.UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("selfConfig")
   
    
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(image, forKey: PropertyKey.imageKey)
        aCoder.encodeObject(word, forKey: PropertyKey.wordKey)
        aCoder.encodeObject(userName, forKey: PropertyKey.userNameKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // Because photo is an optional property of Meal, use conditional cast.
        let image = aDecoder.decodeObjectForKey(PropertyKey.imageKey) as? UIImage
        
        let  word = aDecoder.decodeObjectForKey(PropertyKey.wordKey) as! String
        
        let userName = aDecoder.decodeObjectForKey(PropertyKey.userNameKey)  as? String
        
        // Must call designated initializer.
        self.init(image: image, word: word, userName: userName)
    }
    
//    override init(){
//        super.init()
//        loadSelfConfigs()
//    }
    
    init(image: UIImage?, word: String, userName: String?){
        super.init()
        
        if let image = image {
            self.image = image
        }else {
            self.image = UIImage(named: "defaultImage")
        }
        self.word = word
        self.userName = userName
    }
    
    func saveSelfConfigs(selfConfig: SelfConfig) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(selfConfig, toFile: SelfConfig.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    class func loadSelfConfigs() -> SelfConfig? {
        // print(SelfConfig.ArchiveURL.path)
        return NSKeyedUnarchiver.unarchiveObjectWithFile(SelfConfig.ArchiveURL.path!) as? SelfConfig
    }
    
    class func initInstance() -> SelfConfig {
        let instance = loadSelfConfigs()
        if instance != nil {
            return instance!
        }else {
            return SelfConfig(image: nil, word: "是时候应该做点什么了", userName: "")
        }
    }
    
//    init?(name: String, photo: UIImage?, rating: Int) {
//        self.name = name
//        self.photo = photo
//        self.rating = rating
//        
//        super.init()
//        
//        // Initialization should fail if there is no name or if the rating is negative.
//        if name.isEmpty || rating < 0 {
//            return nil
//        }
//    }
}