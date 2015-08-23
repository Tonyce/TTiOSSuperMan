//
//  LoginStatus.swift
//  superman
//
//  Created by D_ttang on 15/8/5.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation

//let kSecClassValue = kSecClass.takeRetainedValue() as NSString
//let kSecAttrAccountValue = kSecAttrAccount.takeRetainedValue() as NSString
//let kSecValueDataValue = kSecValueData.takeRetainedValue() as NSString
//let kSecClassGenericPasswordValue = kSecClassGenericPassword.takeRetainedValue() as NSString
//let kSecAttrServiceValue = kSecAttrService.takeRetainedValue() as NSString
//let kSecMatchLimitValue = kSecMatchLimit.takeRetainedValue() as NSString
//let kSecReturnDataValue = kSecReturnData.takeRetainedValue() as NSString
//let kSecMatchLimitOneValue = kSecMatchLimitOne.takeRetainedValue() as NSString

class LoginStatus: NSObject {

    var authorizationToken: String?
    var uniqueStr: String?
    let authorizationName = "AuthorizationToken"
    let uniqueStrName = "uniqueStr"

    override init() {
        super.init()
        
        initKeyChain(authorizationName)
//        deleteKeyChain(authorizationName)
        
        initKeyChain(uniqueStrName)
//        deleteKeyChain(uniqueStrName)
        
        authorizationToken = getKeyChain(authorizationName)
        uniqueStr     = getKeyChain(uniqueStrName)
        
    }
    
    // var instance:
    class var sharedInstance: LoginStatus {
        struct Singleton {
            static let instance = LoginStatus()
        }
        return Singleton.instance
    }
    
    func createKeyChainItemDic(keyName: String) -> NSMutableDictionary{
        let keyChainItem = NSMutableDictionary()
        
        keyChainItem.setObject(kSecClassInternetPassword as NSString, forKey: kSecClass as NSString)
//        keyChainItem.setObject(kSecClassGenericPassword as NSString, forKey: kSecClass as NSString)
        keyChainItem.setObject("supermans.cc", forKey:  kSecAttrServer as NSString)
        keyChainItem.setObject(keyName as String, forKey: kSecAttrAccount as NSString)
        return keyChainItem
    }
    
    func deleteKeyChain(name: String) {
        print("delete")
        let keyChainItem = createKeyChainItemDic(name)
        if SecItemCopyMatching(keyChainItem,nil) == noErr{
            let status = SecItemDelete(keyChainItem)
            print("\(name) delet \(status)")
        }else{
            print("\(name) not exit")
        }
    }
    
            
    
    func initKeyChain(name: String) {
        var status:OSStatus?
        let keyChainItem = createKeyChainItemDic(name)
        if SecItemCopyMatching(keyChainItem,nil) == noErr {
//            print("\(name) has exits")
        }else {
//            keyChainItem.setObject(anObject: AnyObject, forKey: NSCopying)
            let value = ""
            keyChainItem.setObject(value.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!, forKey: kSecValueData as String)
            status = SecItemAdd(keyChainItem, nil)
            print("init status \(status)")
        }
    }
    
    
    func updateKeyChain(name: String, value: String) -> OSStatus? {
        print("update")
        var status:OSStatus?
        
        let keyChainItem = createKeyChainItemDic(name)
        if SecItemCopyMatching(keyChainItem,nil) == noErr{
            let updateDictionary = NSMutableDictionary()
            updateDictionary.setObject(value.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true)!, forKey:kSecValueData as String)
            status = SecItemUpdate(keyChainItem, updateDictionary)
            
            print("update \(name) status : \(status)")
        }else{
            
            print("\(name) key chain doesnot exit")
        }
        return status
    }
    
    
    func getKeyChain(name: String) -> String {
//        print("get")
        var secretString = ""
        let keyChainItem = createKeyChainItemDic(name)
        
        keyChainItem.setObject(kCFBooleanTrue, forKey: kSecReturnData as String)
        keyChainItem.setObject(kCFBooleanTrue, forKey: kSecReturnAttributes as String)
        var queryResult: Unmanaged<AnyObject>?
        
        withUnsafeMutablePointer(&queryResult)
            {
                SecItemCopyMatching(keyChainItem as CFDictionaryRef, UnsafeMutablePointer($0))
            }

        let opaque = queryResult?.toOpaque()

        if let op = opaque {
            let retrievedData = Unmanaged<NSDictionary>.fromOpaque(op).takeUnretainedValue()
            let secretData = retrievedData.objectForKey(kSecValueData) as! NSData
            
            secretString = NSString(data: secretData, encoding: NSUTF8StringEncoding)! as String
        }
        return secretString
    }
}

//    //创建默认的描述字典
//    func createDefaultKeyChainItemDic(userName: String)->NSMutableDictionary{
//        let keyChainItem = NSMutableDictionary()
//        keyChainItem.setObject(kSecClassInternetPassword as NSString, forKey: kSecClass as NSString)
//        keyChainItem.setObject("daydayup", forKey:  kSecAttrServer as NSString)
//        keyChainItem.setObject(userName, forKey: kSecAttrAccount as NSString)
//        return keyChainItem
//    }
//

