//
//  LoginStatus.swift
//  superman
//
//  Created by D_ttang on 15/8/5.
//  Copyright © 2015年 D_ttang. All rights reserved.
//
/*
import Foundation

class LoginStatus: NSObject {

    var userName: String?
    var screateKey: String?
    var saveTime: Int?
    
    
    struct PropertyKey {
        static let imageKey = "image"
        static let userNameKey = "name"
        static let wordKey = "word"
    }
    
    //    var instance:
    
    class var sharedInstance: LoginStatus {
        struct Singleton {
            static let instance = LoginStatus()
        }
        return Singleton.instance
    }
    
    
    @IBAction func add(sender: AnyObject) {
        print("add")
        
        let keyChainItem = self.createDefaultKeyChainItemDic()
        if SecItemCopyMatching(keyChainItem,nil) == noErr{
//            self.alertWithMessage("User name already exits")
        }else{
//            keyChainItem.setObject(self.passwordTextfield.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true)!, forKey: kSecValueData as String)
            let status = SecItemAdd(keyChainItem, nil)
//            self.alertWithStatus(status)
        }
    }
    
    
    @IBAction func update(sender: AnyObject) {
        print("update")
        let keyChainItem = self.createDefaultKeyChainItemDic()
        if SecItemCopyMatching(keyChainItem,nil) == noErr{
            let updateDictionary = NSMutableDictionary()
            updateDictionary.setObject(self.passwordTextfield.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true)!, forKey:kSecValueData as String)
            let status = SecItemUpdate(keyChainItem,updateDictionary)
//            self.alertWithStatus(status)
        }else{
//            self.alertWithMessage("The keychain doesnot exist")
        }
    }
    
    @IBAction func deleteKeyChain(sender: AnyObject) {
        print("delete")
        let keyChainItem = self.createDefaultKeyChainItemDic()
        if SecItemCopyMatching(keyChainItem,nil) == noErr{
            let status = SecItemDelete(keyChainItem)
//            self.alertWithStatus(status)
        }else{
//            self.alertWithMessage("The keychain doesnot exist")
            
        }
    }
    
    @IBAction func getKeyChain(sender: AnyObject) {
        print("get")
        let keyChainItem = self.createDefaultKeyChainItemDic(userName!)
        keyChainItem.setObject(kCFBooleanTrue, forKey: kSecReturnData as String)
        keyChainItem.setObject(kCFBooleanTrue, forKey: kSecReturnAttributes as String)
        var queryResult: Unmanaged<AnyObject>?
        _ = SecItemCopyMatching(keyChainItem,&queryResult)
        let opaque = queryResult?.toOpaque()
        //        var contentsOfKeychain: NSString?
        if let op = opaque {
            let retrievedData = Unmanaged<NSDictionary>.fromOpaque(op).takeUnretainedValue()
            let passwordData = retrievedData.objectForKey(kSecValueData) as! NSData
            let passwordString = NSString(data: passwordData, encoding: NSUTF8StringEncoding)!

        }else{

        }
    }
    
    //创建默认的描述字典
    func createDefaultKeyChainItemDic(userName: String)->NSMutableDictionary{
        let keyChainItem = NSMutableDictionary()
        keyChainItem.setObject(kSecClassInternetPassword as NSString, forKey: kSecClass as NSString)
        keyChainItem.setObject("daydayup", forKey:  kSecAttrServer as NSString)
        keyChainItem.setObject(userName, forKey: kSecAttrAccount as NSString)
        return keyChainItem
    }
//    
//    let kSecClassValue = kSecClass.takeRetainedValue() as NSString
//    let kSecAttrAccountValue = kSecAttrAccount.takeRetainedValue() as NSString
//    let kSecValueDataValue = kSecValueData.takeRetainedValue() as NSString
//    let kSecClassGenericPasswordValue = kSecClassGenericPassword.takeRetainedValue() as NSString
//    let kSecAttrServiceValue = kSecAttrService.takeRetainedValue() as NSString
//    let kSecMatchLimitValue = kSecMatchLimit.takeRetainedValue() as NSString
//    let kSecReturnDataValue = kSecReturnData.takeRetainedValue() as NSString
//    let kSecMatchLimitOneValue = kSecMatchLimitOne.takeRetainedValue() as NSString
    
    override init() {
        super.init()
        
    }
}
*/