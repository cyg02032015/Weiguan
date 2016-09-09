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
}
