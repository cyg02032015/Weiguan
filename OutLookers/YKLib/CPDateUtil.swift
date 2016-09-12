//
//  CPDateUtil.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/2.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit
import AFDateHelper

class CPDateUtil {
    static let calendar = NSCalendar.currentCalendar()
    static let dateFormatter = NSDateFormatter()
    
    /**
     String -> NSDate
     
     - parameter dateStr: 日期字符串
     
     - returns: NSDate
     */
    static func stringToDate(dateStr:String)->NSDate{
        return NSDate(fromString:  dateStr, format: .ISO8601(ISO8601Format.DateTimeMilliSec))
    }
    
    /**
     NSDate -> String
     
     - parameter date:       NSDate
     - parameter dateFormat: 日期格式
     
     - returns: String
     */
    static func dateToString(date:NSDate, dateFormat:String)->String{
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.stringFromDate(date)
    }
    
    /**
     返回年月日
     
     - parameter date: NSDate
     
     - returns: NSDateComponents
     */
    static func componentsFromDate(date: NSDate) -> NSDateComponents{
        return calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: date)
    }
    
    static func ageWithDateOfBirth(date: NSDate) -> Int {
        // 出生日期转换 年月日
        let components1 = NSCalendar.currentCalendar().components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: date)
        let brithDateYear  = components1.year
        let brithDateDay   = components1.day
        let brithDateMonth = components1.month
        
        // 获取系统当前 年月日
        let components2 = NSCalendar.currentCalendar().components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: NSDate())
        let currentDateYear  = components2.year;
        let currentDateDay   = components2.day;
        let currentDateMonth = components2.month;
        
        // 计算年龄
        var iAge = currentDateYear - brithDateYear - 1
        if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
            iAge += 1
        }
        return iAge
    }
}
