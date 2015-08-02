//
//  JSONHandler.swift
//  myLogin
//
//  Created by D_ttang on 15/6/22.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation

enum JSONValue {
    
    case JSONObject([String:JSONValue])
    case JSONArray([JSONValue])
    case JSONString(String)
    case JSONNumber(NSNumber)
    case JSONBool(Bool)
    case JSONNull
    
    var object: [String: JSONValue]? {
        switch self {
        case .JSONObject(let value):
            return value
        default:
            return nil
        }
    }
    
    var array: [JSONValue]? {
        switch self {
        case .JSONArray(let value):
            return value
        default:
            return nil
        }
    }
    
    var string: String? {
        switch self {
        case .JSONString(let value):
            return value
        default:
            return nil
        }
    }
    
    var integer: Int? {
        switch self {
        case .JSONNumber(let value):
            return value.integerValue
        default:
            return nil
        }
    }
    
    var double: Double? {
        switch self {
        case .JSONNumber(let value):
            return value.doubleValue
        default:
            return nil
        }
    }
    
    var bool: Bool? {
        switch self {
        case .JSONBool(let value):
            return value
        case .JSONNumber(let value):
            return value.boolValue
        default:
            return nil
        }
    }
    
    subscript(i: Int) -> JSONValue? {
        get {
            switch self {
            case .JSONArray(let value):
                return value[i]
            default:
                return nil
            }
        }
    }
    
    subscript(key: String) -> JSONValue? {
        get {
            switch self {
            case .JSONObject(let value):
                return value[key]
            default:
                return nil
            }
        }
    }
    
    static func fromObject(object: AnyObject) -> JSONValue? {
        switch object {
        case let value as NSString:
            return JSONValue.JSONString(value as String)
        case let value as NSNumber:
            return JSONValue.JSONNumber(value)
        case let value as NSDictionary:
            var jsonObject: [String: JSONValue] = [:]
            for(_k, _v) in value {
                if let k = _k as? NSString, let v = JSONValue.fromObject(_v){
                    jsonObject[k as String] = v
                }else {
                    return nil
                }
            }
            return JSONValue.JSONObject(jsonObject)
        case let value as NSArray:
            var jsonArray: [JSONValue] = []
            for _v in value {
                if let v = JSONValue.fromObject(_v){
                    jsonArray.append(v)
                }else {
                    return nil
                }
            }
            return JSONValue.JSONArray(jsonArray)
        case _ as NSNull:
            return JSONValue.JSONNull
        default:
            return nil
        }
    }
}