//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"

var model = [
    "c": ["c", "c", "c"],
    
    "b": ["b", "b"],
    "a": ["a"]
]

model["a"]
var keys: Array = [String](model.keys)

var a = ["a": "b"]
var b = ["b": "a"]

a == b

NSDate().description
NSDate().getMirror()
NSDate()

var dateFormatter1 = NSDateFormatter()
dateFormatter1.dateStyle = NSDateFormatterStyle.MediumStyle
dateFormatter1.timeStyle = NSDateFormatterStyle.MediumStyle
var now = NSDate()
// Date 转 String
var nowString = dateFormatter1.stringFromDate(now)      // Mar 24, 2015, 9:00:00 PM
// String 转 Date
now = dateFormatter1.dateFromString(nowString)!

// 方式2：自定义日期格式进行转换
var dateFormatter2 = NSDateFormatter()
dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
// Date 转 String
nowString = dateFormatter2.stringFromDate(now)          // 2015-03-24 21:00:00
// String 转 Date
now = dateFormatter2.dateFromString(nowString)!

//var now = NSDate()
// 初始化一个明天当前时刻对象
var tomorrow = NSDate(timeIntervalSinceNow: 24*60*60)
// 初始化一个昨天当前时刻对象
var yestoday = NSDate(timeInterval: -24*60*60, sinceDate: now)
// 初始化一个 2001-01-01 08:00:00 1小时后的时刻对象
var date1 = NSDate(timeIntervalSinceReferenceDate: 3600)
// 初始化一个 1970-01-01 08:00:00 1小时后的时刻对象
var date2 = NSDate(timeIntervalSince1970: 3600)

// 2、获取时间描述
var dateDescription = now.description

// 3、获取时间间隔
// 获取今天到明天的时间间隔
var interval1 = tomorrow.timeIntervalSinceDate(now)
// 获取今天到明天的时间间隔
var interval2 = tomorrow.timeIntervalSinceNow
// 获取 2001-01-01 08:00:00 到今天的时间间隔
var interval3 = now.timeIntervalSinceReferenceDate
// 获取 1970-01-01 08:00:00 到今天的时间间隔
var interval5 = now.timeIntervalSince1970

// 4、随机返回一个不可能达到的未来时间、过去时间
date1 = NSDate.distantFuture() as NSDate
date2 = NSDate.distantPast() as NSDate

// 5、时间相加
// 返回一个后天当前时刻对象（在明天基础上再加上一天的时间）
var theDayAfterTomorrow = tomorrow.dateByAddingTimeInterval(24*60*60)

// 6、时间比较
// 比较两个时间对象是否相同返回布尔值（由于精度问题，isTheSameDate 为 false）
var isTheSameDate = theDayAfterTomorrow.isEqualToDate(NSDate(timeInterval: 2*24*60*60, sinceDate: now))
// 返回两个时间中较早的一个时间
var earlierOne = now.earlierDate(tomorrow)
// 返回两个时间中较晚的一个时间
var laterOne = now.laterDate(tomorrow)
// 比较两个时间对象是否相同并返回 NSComparisonResult 值
var compareResult = now.compare(tomorrow)

func getDayOfWeek(today:String)->Int? {
    
    let formatter  = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    if let todayDate = formatter.dateFromString(today) {
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(NSCalendarUnit.WeekOfYear, fromDate: todayDate)
        let weekDay = myComponents.weekOfYear
        return weekDay
    } else {
        return nil
    }
}

if let weekday = getDayOfWeek("2014-08-27") {
    print(weekday)
} else {
    print("bad input")
}
