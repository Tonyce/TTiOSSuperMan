//
//  MyHTTPHandler.swift
//  myLogin
//
//  Created by D_ttang on 15/6/22.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation

class MyHTTPHandler {
    class func get(url: String, callback: (data: NSData?, response: NSHTTPURLResponse?, err: NSError?) -> Void){
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
//        let token = LoginStatus.sharedInstance.authorizationToken!
//        print("token: \(token) ")
        request.addValue(LoginStatus.sharedInstance.authorizationToken!, forHTTPHeaderField: "Authorization")
        let task = session.dataTaskWithRequest(request){
            data, response, error -> Void in
            
            //let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //print("Body: \(strData)")
            
            callback(data: data, response: response as? NSHTTPURLResponse, err: error )
        }
        task.resume()
    }
    
    class func post( url: String, params: Dictionary<String, AnyObject>, callback: (data: NSData?, response: NSHTTPURLResponse?, err: NSError?) -> Void ){
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        // let params = ["username":"jameson", "password":"password"]
        let params = params
        do{
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue: 0))
        }catch _ {
            print("err")
            return
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.addValue(LoginStatus.sharedInstance.authorizationToken!, forHTTPHeaderField: "Authorization")
        let task = session.dataTaskWithRequest(request, completionHandler: {
            data, response, error -> Void in
            
            // let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            // print("Body: \(strData)")
            
            callback(data: data, response: response as? NSHTTPURLResponse, err: error)

            /*
            if error != nil {
                print("error:\(error)")
                return
            }
            // print("Response: \(response)")
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
                print("json\(json)")
            }catch _ {
                print("err")
                return
            }
            */
            
        })
        task.resume()
    }
    
    class func post( url: String, paramsArr: [AnyObject], callback: (data: NSData?, response: NSHTTPURLResponse?, err: NSError?) -> Void ){
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"

        let params = paramsArr
        do{
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue: 0))
        }catch _ {
            print("err")
            return
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.addValue(LoginStatus.sharedInstance.authorizationToken!, forHTTPHeaderField: "Authorization")
        let task = session.dataTaskWithRequest(request, completionHandler: {
            data, response, error -> Void in
            
            callback(data: data, response: response as? NSHTTPURLResponse, err: error)
        })
        task.resume()
    }
}